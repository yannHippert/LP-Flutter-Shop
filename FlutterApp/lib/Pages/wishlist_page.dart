import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Pages/product_page.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_sweater_shop/Widgets/loading_overlay.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
import 'package:flutter_sweater_shop/Widgets/wishlist_item_card.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware/wishlist.dart';
import 'package:flutter_sweater_shop/redux/middleware/basket.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:redux/redux.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  bool _isLoading = true;
  bool _isActionInProgress = false;

  void _fetchProducts(Store store) async {
    Completer completer = Completer();
    store.dispatch(fetchWishlist(completer));
    completer.future
        .onError(_handleError)
        .whenComplete(() => setState(() => _isLoading = false));
  }

  void _removeFromWishlist(ShoppingItem item, {showUndo = false}) {
    if (showUndo) setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(removeWishlistItem(item, completer));
    completer.future
        .then((_) => showUndo
            ? showScaffoldMessage(
                context,
                AppLocalizations.of(context)!
                    .item_removed_from_wishlist(item.name),
                action: SnackBarAction(
                  label: AppLocalizations.of(context)!.undo,
                  onPressed: () => _addToWishlist(item),
                ),
              )
            : null)
        .catchError(_handleError)
        .whenComplete(
      () {
        if (showUndo) setState(() => _isActionInProgress = false);
      },
    );
  }

  void _addToWishlist(ShoppingItem item) {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addWishlistItem(item, completer));
    completer.future
        .catchError(_handleError)
        .whenComplete(() => setState(() => _isActionInProgress = false));
  }

  void _addToBasket(ShoppingItem item) {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addBasketItem(item, completer));
    completer.future
        .then(
          (_) => showScaffoldMessage(
            context,
            AppLocalizations.of(context)!.item_added_to_basket(item.name),
          ),
        )
        .catchError(_handleError)
        .whenComplete(() => setState(() => _isActionInProgress = false));
  }

  void _moveToBasket(ShoppingItem item) {
    _removeFromWishlist(item);
    _addToBasket(item);
  }

  void _navigateToProductPage(String productId) {
    ApiClient.fetchProduct(productId).then((product) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(product: product),
        ),
      );
    }).catchError((_) {
      showScaffoldMessage(
        context,
        AppLocalizations.of(context)!.err_loading_product,
      );
    });
  }

  void _handleError(Object? error, StackTrace stackTrace) {
    if (error is ApiException) {
      showScaffoldMessage(
        context,
        AppLocalizations.of(context)!.err_server_connection,
      );
    } else {
      if (kDebugMode) print(stackTrace.toString());
    }
  }

  Widget _buildDissmissibleContainer({
    required Color backgroundColor,
    required IconData iconData,
    required String text,
    isLeft = true,
  }) {
    var children = [
      const SizedBox(width: 15),
      Icon(
        iconData,
        color: Colors.white,
        size: 40.0,
      ),
      const SizedBox(width: 5),
      Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    ];

    if (!isLeft) children = children.reversed.toList();

    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment:
            isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      StoreConnector<AppState, List<ShoppingItem>>(
        onInit: _fetchProducts,
        converter: (store) => store.state.wishlist,
        builder: (context, whishlist) {
          if (_isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (whishlist.isEmpty) {
            return NoEntriesDisplay(
              iconData: Icons.star_border,
              text: AppLocalizations.of(context)!.empty_wishlist,
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: whishlist.length,
            itemBuilder: (context, index) {
              final wishlistItem = whishlist[index];
              return InkWell(
                onTap: () => _navigateToProductPage(wishlistItem.id),
                child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    background: _buildDissmissibleContainer(
                        backgroundColor: Colors.red,
                        iconData: Icons.delete,
                        text:
                            AppLocalizations.of(context)!.remove_from_wishlist),
                    secondaryBackground: _buildDissmissibleContainer(
                        backgroundColor: Colors.blue,
                        iconData: Icons.shopping_cart,
                        text: AppLocalizations.of(context)!.add_to_basket,
                        isLeft: false),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        _removeFromWishlist(wishlistItem, showUndo: true);
                      } else {
                        _moveToBasket(wishlistItem);
                      }
                    },
                    child: WishlistItemCard(wishlistItem)),
              );
            },
          );
        },
      ),
      _isActionInProgress ? LoadingOverlay() : const SizedBox.shrink(),
    ]);
  }
}
