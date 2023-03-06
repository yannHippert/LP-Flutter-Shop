import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware/wishlist.dart';
import 'package:flutter_sweater_shop/redux/middleware/basket.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Widgets/filtered_image.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'product_page.dart';
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
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(removeWishlistItem(item, completer));
    completer.future.then((_) => showUndo
        ? showScaffoldMessage(
            context,
            AppLocalizations.of(context)!.item_removed_from_wishlist(item.name),
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.undo,
              onPressed: () => _addToWishlist(item),
            ),
          )
        : null); //.catchError(_handleError);
  }

  void _addToWishlist(ShoppingItem item) {
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addWishlistItem(item, completer));
    completer.future.catchError(_handleError);
  }

  void _addToBasket(ShoppingItem item) {
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
        .catchError(_handleError);
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

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<ShoppingItem>>(
      onInit: _fetchProducts,
      converter: (store) => store.state.whishlist,
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
        return Scaffold(
          body: ListView.builder(
            itemCount: whishlist.length,
            itemBuilder: (context, index) {
              final whishlistItem = whishlist[index];
              return InkWell(
                  onTap: () => _navigateToProductPage(whishlistItem.id),
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            AppLocalizations.of(context)!.remove_from_wishlist,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      // Background for swiping right
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.add_to_basket,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                    // drag to the left to delete
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        _removeFromWishlist(whishlistItem, showUndo: true);
                      } else {
                        _moveToBasket(whishlistItem);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                whishlistItem.name,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                currencyFormatter.format(whishlistItem.price),
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: FilteredImage(
                              imageUrl: whishlistItem.image,
                              color: whishlistItem.productColor?.color,
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}
