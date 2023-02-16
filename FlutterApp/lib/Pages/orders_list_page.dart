import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Order>>(
      converter: (store) => store.state.orders,
      builder: (context, List<Order> orders) => ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  title: Text(orders[index].id),
                  subtitle: Text(dateFormatter.format(orders[index].date)),
                  trailing:
                      Text(currFormatter.format(orders[index].totalPrice))));
        },
      ),
    );
  }
}
