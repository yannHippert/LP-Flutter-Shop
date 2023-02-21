import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
import 'package:flutter_sweater_shop/Widgets/order_card.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/Exceptions/ApiException.dart';
import 'package:flutter_sweater_shop/redux/middleware/order.dart';
import 'package:redux/redux.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  bool _isLoading = true;

  void _fetchOrders(Store store) async {
    Completer completer = Completer();
    store.dispatch(fetchOrders(completer));
    try {
      await completer.future;
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onError(ApiException e) {
    print("Error : $e");
  }

  Widget _buildNoEntries() {
    return NoEntriesDisplay(
      iconData: Icons.receipt,
      text: AppLocalizations.of(context)!.no_orders_yet,
    );
  }

  Widget _buildLoading(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, _) => const SkeletonOrderCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Order>>(
        onInit: _fetchOrders,
        converter: (store) => store.state.orders,
        builder: (context, List<Order> orders) {
          if (_isLoading) return _buildLoading(context);
          if (orders.isEmpty) return _buildNoEntries();
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) => index % 2 == 0
                ? const SkeletonOrderCard()
                : OrderCard(order: orders[index]),
          );
        });
  }
}
