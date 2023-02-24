import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/notification.dart';
import 'package:flutter_sweater_shop/Widgets/basket_item_card.dart';
import 'package:flutter_sweater_shop/Widgets/loading_overlay.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/redux/middleware/basket.dart';
import 'package:redux/redux.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  bool _isLoading = true;
  bool _isActionInProgress = false;

  void _fetchBasket(Store store) async {
    Completer completer = Completer();
    store.dispatch(fetchBasket(completer));
    try {
      await completer.future;
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onDeleteItem(String itemId) async {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(deleteBasketItem(itemId, completer));
    try {
      await completer.future;
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() => _isActionInProgress = false);
    }
  }

  void _onDecrementQuantity(String itemId) async {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(decrementQuantity(itemId, completer));
    try {
      await completer.future;
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() => _isActionInProgress = false);
    }
  }

  void _onIncrementQuantity(String itemId) async {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(incrementQuantity(itemId, completer));
    try {
      await completer.future;
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() => _isActionInProgress = false);
    }
  }

  void _onError(ApiException e) {
    showErrorNotification(
      context,
      "An error occured while loading the basket!",
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

  Widget _buildBasketItems(BuildContext context) {
    return StoreConnector<AppState, List<ShoppingItem>>(
      onInit: _fetchBasket,
      converter: (store) => store.state.basket,
      builder: (context, List<ShoppingItem> basket) {
        if (_isLoading) return _buildLoading();
        if (basket.isEmpty) return _buildNoEntries();
        return ListView.separated(
          separatorBuilder: (context, _) => const SizedBox(height: 5),
          itemCount: basket.length,
          itemBuilder: (context, index) {
            var basketItem = basket[index];
            return BasketItemCard(
              basketItem: basketItem,
              onDelete: () => _onDeleteItem(basketItem.itemId),
              onDecrementQuantity: () =>
                  _onDecrementQuantity(basketItem.itemId),
              onIncrementQuantity: () =>
                  _onIncrementQuantity(basketItem.itemId),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: _buildBasketItems(context),
            ),
          ],
        ),
      ),
      _isActionInProgress ? const LoadingOverlay() : const SizedBox.shrink(),
    ]);
  }
}
