import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/Exceptions/ApiException.dart';
import 'package:flutter_sweater_shop/redux/middleware.dart';
import 'package:redux/redux.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  static const double iconSize = 48;

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.receipt, size: iconSize),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.no_orders_yet),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Order>>(
        onInit: _fetchOrders,
        converter: (store) => store.state.orders,
        builder: (context, List<Order> orders) {
          if (_isLoading) return buildLoadingIndicator();
          if (orders.isEmpty) return _buildNoEntries();
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                      title: Text(orders[index].id),
                      subtitle: Text(dateFormatter.format(orders[index].date)),
                      trailing: Text(
                          currFormatter.format(orders[index].totalPrice))));
            },
          );
        });
  }
}
