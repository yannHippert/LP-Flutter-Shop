import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Pages/confirm_payment_page.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_sweater_shop/Widgets/basket_item_card.dart';
import 'package:flutter_sweater_shop/Widgets/loading_overlay.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/redux/middleware/basket.dart';
import 'package:flutter_sweater_shop/redux/middleware/wishlist.dart';
import 'package:redux/redux.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  bool _isLoading = true;
  bool _isActionInProgress = false;

  void _fetchBasket(Store store) {
    Completer completer = Completer();
    store.dispatch(fetchBasket(completer));
    completer.future
        .onError(_handleError)
        .whenComplete(() => setState(() => _isLoading = false));
  }

  void _handleDeleteItem(String itemId) {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(removeBasketItem(itemId, completer));
    completer.future
        .onError(_handleError)
        .whenComplete(() => setState(() => _isActionInProgress = false));
  }

  void _handleDecrementQuantity(String itemId) {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(decrementQuantity(itemId, completer));
    completer.future
        .onError(_handleError)
        .whenComplete(() => setState(() => _isActionInProgress = false));
  }

  void _handleIncrementQuantity(String itemId) {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(incrementQuantity(itemId, completer));
    completer.future
        .onError(_handleError)
        .whenComplete(() => setState(() => _isActionInProgress = false));
  }

  void _handleError(Object? error, StackTrace stackTrace) {
    if (error is ApiException) {
      showScaffoldMessage(
        context,
        AppLocalizations.of(context)!.err_loading_basket,
      );
    } else {
      if (kDebugMode) print(stackTrace.toString());
    }
  }

  void _handleMoveToWishlist(ShoppingItem item) {
    setState(() => _isActionInProgress = true);
    Completer basketCompleter = Completer();
    Completer wishlistCompleter = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(removeBasketItem(item.itemId, basketCompleter));
    store.dispatch(addWishlistItem(item, wishlistCompleter));
    Future.wait([basketCompleter.future, wishlistCompleter.future])
        .then((_) => showScaffoldMessage(
              context,
              AppLocalizations.of(context)!.item_added_to_basket(item.name),
            ))
        .catchError(_handleError)
        .whenComplete(() => setState(() => _isActionInProgress = false));
  }

  void _handleCheckout() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ConfirmPaymentPage()),
    );
  }

  Widget _buildLoading() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => const Text("Loading"),
    );
  }

  Widget _buildNoEntries() {
    return NoEntriesDisplay(
      text: AppLocalizations.of(context)!.empty_basket,
      iconData: Icons.shopping_cart_outlined,
    );
  }

  Widget _buildCheckout(List<ShoppingItem> basket) {
    if (_isLoading || basket.isEmpty) return const SizedBox.shrink();
    Order order = Order.fromBasket(basket);

    return Column(
      children: [
        Text(
          "${AppLocalizations.of(context)!.subtotal} ${currencyFormatter.format(order.subtotal)}",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        ElevatedButton(
          onPressed: _handleCheckout,
          child: Text(
            AppLocalizations.of(context)!.checkout_proceed(order.itemQuantity),
          ),
        )
      ],
    );
  }

  Widget _buildBasketItems(List<ShoppingItem> basket) {
    if (_isLoading) return _buildLoading();
    if (basket.isEmpty) return _buildNoEntries();
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, _) => const SizedBox(height: 5),
      itemCount: basket.length,
      itemBuilder: (context, index) {
        var basketItem = basket[index];
        return BasketItemCard(
          basketItem: basketItem,
          onDelete: () => _handleDeleteItem(basketItem.itemId),
          onDecrementQuantity: () =>
              _handleDecrementQuantity(basketItem.itemId),
          onIncrementQuantity: () =>
              _handleIncrementQuantity(basketItem.itemId),
          onMoveToWishlist: () => _handleMoveToWishlist(basketItem),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: pagePadding,
          child: StoreConnector<AppState, List<ShoppingItem>>(
            onInit: _fetchBasket,
            converter: (store) => store.state.basket,
            builder: (context, List<ShoppingItem> basket) => Column(
              children: [
                _buildCheckout(basket),
                Expanded(child: _buildBasketItems(basket))
              ],
            ),
          ),
        ),
        _isActionInProgress ? const LoadingOverlay() : const SizedBox.shrink(),
      ],
    );
  }
}
