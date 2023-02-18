import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/styles.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(order.id),
            subtitle: Text(dateFormatter.format(order.date)),
            trailing: Text(currFormatter.format(order.totalPrice))));
  }
}

class SkeletonOrderCard extends StatelessWidget {
  const SkeletonOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Shimmer.fromColors(
          baseColor: Colors.grey.shade500,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: cBorderRadius,
            ),
          ),
        ),
        subtitle: Shimmer.fromColors(
          baseColor: Colors.grey.shade500,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: cBorderRadius,
            ),
          ),
        ),
        trailing: Shimmer.fromColors(
          baseColor: Colors.grey.shade500,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 14,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: cBorderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
