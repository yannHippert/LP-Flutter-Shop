
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoEntriesDisplay extends StatelessWidget {
  static const double iconSize = 48;
  static const double itemGap = 16;

  final IconData iconData;
  final String text;

  const NoEntriesDisplay(
      {super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: iconSize),
          const SizedBox(height: itemGap),
          Text(text),
        ],
      ),
    );
  }
}
