import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/Widgets/loading_overlay.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/redux/middleware/order.dart';
import 'package:redux/redux.dart';

class ConfirmPaymentPage extends StatefulWidget {
  const ConfirmPaymentPage({Key? key}) : super(key: key);

  @override
  _ConfirmPaymentPageState createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  bool _isActionInProgress = false;

  void _confirmPayment(Order order) {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addOrder(completer, order));
    completer.future
        .then((_) => _handlePaymentSucess())
        .onError(_handleError)
        .whenComplete(() => setState(() => _isActionInProgress = false));
  }

  void _handlePaymentSucess() {
    showScaffoldMessage(context, AppLocalizations.of(context)!.order_placed);
    Navigator.pop(context);
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

  Widget _buildSpacedText(String text1, String text2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(
        child: Text(
          text1,
          maxLines: 2,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      Text(text2, style: Theme.of(context).textTheme.displayMedium)
    ]);
  }

  Widget _buildItemListing(ShoppingItem item) {
    var itemProperties = [];
    if (item.hasColor) itemProperties.add(item.productColor!.name);
    if (item.hasSize) itemProperties.add(item.productSize!.name);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSpacedText("${item.quantity} x ${item.name}",
            currencyFormatter.format(item.price * item.quantity)),
        Text(itemProperties.join(", "))
      ],
    );
  }

  Widget _buildContent(List<ShoppingItem> basket) {
    var order = Order.fromBasket(basket);

    return Column(
      children: [
        Flexible(
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: basket.length,
              separatorBuilder: (_, index) => const SizedBox(height: 5),
              itemBuilder: (context, index) =>
                  _buildItemListing(basket[index])),
        ),
        const Divider(color: Colors.white),
        _buildSpacedText(AppLocalizations.of(context)!.subtotal,
            currencyFormatter.format(order.subtotal)),
        _buildSpacedText(AppLocalizations.of(context)!.shipping_fee,
            currencyFormatter.format(order.shipping)),
        const Divider(color: Colors.white),
        _buildSpacedText(AppLocalizations.of(context)!.total,
            currencyFormatter.format(order.total)),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () => _confirmPayment(order),
            child: Text(AppLocalizations.of(context)!.confirm_payment)),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.checkout),
        ),
        body: Container(
          padding: pagePadding,
          child: StoreConnector<AppState, List<ShoppingItem>>(
            converter: (store) => store.state.basket,
            builder: (context, List<ShoppingItem> basket) =>
                _buildContent(basket),
          ),
        ),
      ),
      _isActionInProgress ? LoadingOverlay() : const SizedBox.shrink(),
    ]);
  }
}
