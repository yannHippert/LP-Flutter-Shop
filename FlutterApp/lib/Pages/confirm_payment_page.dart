import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/notification.dart';
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

  void _onError(ApiException e) {
    showErrorNotification(
      context,
      "An error occured while loading the basket!",
    );
  }

  Widget _buildSpacedText(String text1, String text2) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text1, style: Theme.of(context).textTheme.displayMedium),
      Text(text2, style: Theme.of(context).textTheme.displayMedium)
    ]);
  }

  Widget _buildContent(List<ShoppingItem> basket) {
    var order = Order.fromBasket(basket);

    return Column(
      children: [
        const Divider(color: Colors.white),
        _buildSpacedText(AppLocalizations.of(context)!.subtotal,
            currencyFormatter.format(order.subtotal)),
        _buildSpacedText(AppLocalizations.of(context)!.shipping_fee,
            currencyFormatter.format(order.shipping)),
        const Divider(color: Colors.white),
        _buildSpacedText(AppLocalizations.of(context)!.total,
            currencyFormatter.format(order.total)),
        ElevatedButton(
            onPressed: () => _confirmPayment(order),
            child: Text(AppLocalizations.of(context)!.confirm_payment))
      ],
    );
  }

  void _confirmPayment(Order order) async {
    setState(() => _isActionInProgress = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addOrder(completer, order));
    try {
      await completer.future;
      _handlePaymentSucess();
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() => _isActionInProgress = false);
    }
  }

  void _handlePaymentSucess() {
    showSuccessNotification(context, "Order placed");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.checkout),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: StoreConnector<AppState, List<ShoppingItem>>(
            converter: (store) => store.state.basket,
            builder: (context, List<ShoppingItem> basket) =>
                _buildContent(basket),
          ),
        ),
      ),
      _isActionInProgress ? const LoadingOverlay() : const SizedBox.shrink(),
    ]);
  }
}
