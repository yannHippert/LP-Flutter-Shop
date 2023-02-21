import 'package:flutter_sweater_shop/Models/shopping_item.dart';

class AddBasketItemAction {
  final ShoppingItem basketItem;
  final int quantity;

  AddBasketItemAction(this.basketItem, this.quantity);
}

class SetBasketAction {
  final List<ShoppingItem> payload;

  SetBasketAction(this.payload);
}

class DeleteBasketItemAction {
  final String itemId;

  DeleteBasketItemAction(this.itemId);
}
