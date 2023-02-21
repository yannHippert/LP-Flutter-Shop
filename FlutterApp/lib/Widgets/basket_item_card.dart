import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/styles.dart';
import 'package:flutter_sweater_shop/Widgets/filtered_image.dart';
import 'package:intl/intl.dart';

const _containerPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 10);

var _containerDecoration = BoxDecoration(
  color: Colors.white10,
  borderRadius: cBorderRadius,
  boxShadow: const [cBoxshadow],
);

const _hSpacer = SizedBox(width: 5);

const _vSpacer = SizedBox(height: 5);

class BasketItemCard extends StatelessWidget {
  final oCcy = NumberFormat.simpleCurrency(locale: "fr_EU");
  final ShoppingItem basketItem;
  final Function() onDelete;

  BasketItemCard({super.key, required this.basketItem, required this.onDelete});

  Widget _buildImage() {
    Color? color = basketItem.hasColor ? basketItem.productColor!.color : null;
    return FilteredImage(
      imageUrl: basketItem.image,
      color: color,
      width: 175,
      height: 175,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _containerPadding,
      decoration: _containerDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: _buildImage(),
            ),
            _hSpacer,
            Column(
              children: [
                Text(basketItem.name),
                _vSpacer,
                Text(
                  oCcy.format(basketItem.price),
                )
              ],
            )
          ]),
          _vSpacer,
          Row(
            children: [
              ElevatedButton(onPressed: () => {}, child: Text("-")),
              Text("${basketItem.quantity}"),
              ElevatedButton(onPressed: () => {}, child: Text("+")),
              _hSpacer,
              ElevatedButton(onPressed: onDelete, child: Text("Delete")),
              _hSpacer,
              ElevatedButton(onPressed: () => {}, child: Text("Save for later"))
            ],
          )
        ],
      ),
    );
  }
}
