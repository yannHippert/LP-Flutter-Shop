import 'package:flutter_sweater_shop/Models/order.dart';

class SetOrdersAction {
  final List<Order> payload;

  SetOrdersAction(this.payload);
}
