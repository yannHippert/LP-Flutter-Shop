import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Widgets/filtered_image.dart';

class WishlistItemCard extends StatelessWidget {
  final ShoppingItem wishlistItem;

  const WishlistItemCard(this.wishlistItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                wishlistItem.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                currencyFormatter.format(wishlistItem.price),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FilteredImage(
              imageUrl: wishlistItem.image,
              color: wishlistItem.productColor?.color,
              width: 90,
              height: 90,
            ),
          ),
        ],
      ),
    );
  }
}
