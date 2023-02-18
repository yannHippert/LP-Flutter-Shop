import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Utilities/styles.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final double width;
  final Product product;

  const ProductCard({super.key, required this.product, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: cBorderRadius,
        boxShadow: const [cBoxshadow],
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

class SkeletonProductCard extends StatelessWidget {
  final double width;

  const SkeletonProductCard({super.key, this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: cBorderRadius,
        boxShadow: const [cBoxshadow],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width - 20,
              height: width - 20,
              decoration: BoxDecoration(
                borderRadius: cBorderRadius,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: width - 50,
              height: 14,
              decoration: BoxDecoration(
                borderRadius: cBorderRadius,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
