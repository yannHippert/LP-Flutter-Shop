import 'package:flutter_sweater_shop/Models/shopping_item.dart';

class SetWishlistAction {
  final List<ShoppingItem> payload;

  SetWishlistAction(this.payload);
}

class AddWishlistItemAction {
  final ShoppingItem wishlistItem;

  AddWishlistItemAction(this.wishlistItem);
}
