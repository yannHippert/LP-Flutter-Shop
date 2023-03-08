import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Pages/order_page.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
import 'package:flutter_sweater_shop/Widgets/order_card.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/redux/middleware/order.dart';
import 'package:redux/redux.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  bool _isLoading = true;

  void _fetchOrders(Store store) {
    Completer completer = Completer();
    store.dispatch(fetchOrders(completer));
    completer.future
        .onError(_handleError)
        .whenComplete(() => setState(() => _isLoading = false));
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

  void _onTap(Order order) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => OrderPage(order: order)),
    );
  }

  Widget _buildNoEntries() {
    return NoEntriesDisplay(
      iconData: Icons.receipt,
      text: AppLocalizations.of(context)!.no_orders_yet,
    );
  }

  Widget _buildLoading(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, _) => const SkeletonOrderCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: pagePadding,
      child: StoreConnector<AppState, List<Order>>(
        onInit: _fetchOrders,
        converter: (store) => store.state.orders,
        builder: (context, List<Order> orders) {
          if (_isLoading) return _buildLoading(context);
          if (orders.isEmpty) return _buildNoEntries();
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () => _onTap(orders[index]),
                child: OrderCard(order: orders[index])),
          );
        },
      ),
    );
  }
}
