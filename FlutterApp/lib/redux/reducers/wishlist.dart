import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/redux/actions/wishlist.dart';

List<ShoppingItem> wishlistReducer(List<ShoppingItem> wishlist, action) {
  if (action is SetWishlistAction) {
    return action.payload;
  }

  if (action is AddWishlistItemAction) {
    bool found = false;
    List<ShoppingItem> newWishlist = wishlist.map((e) {
      if (e.itemId == action.wishlistItem.itemId) {
        e.quantity = 1;
        found = true;
      }
      return e;
    }).toList();

    return found ? newWishlist : [...wishlist, action.wishlistItem];
  }

  if (action is RemoveWishlistItemAction) {
    return wishlist
        .where((element) => element.itemId != action.wishlistItem.itemId)
        .toList();
  }

  return wishlist;
}
