import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Utilities/styles.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  double width;
  final Product product;

  ProductCard({super.key, required this.product, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: CBorderRadius,
        boxShadow: const [CBoxshadow],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Image.network(
              product.image,
              width: width - 20,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            product.name,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
