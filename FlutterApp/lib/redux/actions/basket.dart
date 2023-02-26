import 'package:flutter_sweater_shop/Models/shopping_item.dart';

class SetBasketAction {
  final List<ShoppingItem> payload;

  SetBasketAction(this.payload);
}

class AddBasketItemAction {
  final ShoppingItem basketItem;

  AddBasketItemAction(this.basketItem);
}

class UpdateBasketItemAction {
  final ShoppingItem item;

  UpdateBasketItemAction(this.item);
}

class IncrementQuantityAction {
  final String itemId;

  IncrementQuantityAction(this.itemId);
}

class DecrementQuantityAction {
  final String itemId;

  DecrementQuantityAction(this.itemId);
}

class DeleteBasketItemAction {
  final String itemId;

  DeleteBasketItemAction(this.itemId);
}
