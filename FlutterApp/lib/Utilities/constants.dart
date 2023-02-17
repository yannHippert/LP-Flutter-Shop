import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final currFormatter = NumberFormat.simpleCurrency(locale: "fr_EU");

final dateFormatter = DateFormat("dd/MM/yyyy HH:mm");

Widget buildLoadingIndicator({double? iconSize = 48}) {
  return Center(
    child: SizedBox(
      width: iconSize,
      height: iconSize,
      child: const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      ),
    ),
  );
}
