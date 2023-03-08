import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const emailKey = "KEY_EMAIL";
const passwordKey = "KEY_PASSWORD";

const infoMessageDuration = Duration(seconds: 2);

const pagePaddingSize = 10.0;
const pagePadding = EdgeInsets.all(pagePaddingSize);

final dateFormatter = DateFormat("dd/MM/yyyy HH:mm");

final currencyFormatter = NumberFormat.currency(
  locale: "fr_EU",
  decimalDigits: 2,
  symbol: "€",
);

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
