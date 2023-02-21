import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Utilities/styles.dart';
import 'package:flutter_sweater_shop/Widgets/filtered_image.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

double _getImageWidth(double width) => width - 10;

const _containerPadding = EdgeInsets.symmetric(horizontal: 12, vertical: 10);

var _containerDecoration = BoxDecoration(
  color: Colors.white10,
  borderRadius: cBorderRadius,
  boxShadow: const [cBoxshadow],
);

const _spacer = SizedBox(height: 5);

class ProductCard extends StatelessWidget {
  final oCcy = NumberFormat.simpleCurrency(locale: "fr_EU");
  final double width;
  final VariableProduct product;

  ProductCard({super.key, required this.product, this.width = 150});

  Widget _buildImage() {
    Color? color =
        product.isColorable ? product.colors.elementAt(0).color : null;
    return FilteredImage(
      imageUrl: product.image,
      color: color,
      width: _getImageWidth(width),
      height: _getImageWidth(width),
    );
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildColorOptions() {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        spacing: 5,
        children: product.colors.map((e) => _buildCircle(e.color)).toList(),
      ),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: _buildImage(),
          ),
          _spacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                oCcy.format(product.minPrice),
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
          _spacer,
          _buildColorOptions()
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
      padding: _containerPadding,
      decoration: _containerDecoration,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: _getImageWidth(width),
              height: _getImageWidth(width),
              decoration: BoxDecoration(
                borderRadius: cBorderRadius,
                color: Colors.white,
              ),
            ),
            _spacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width - 70,
                  height: 14,
                  decoration: BoxDecoration(
                    borderRadius: cBorderRadius,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 40,
                  height: 14,
                  decoration: BoxDecoration(
                    borderRadius: cBorderRadius,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
