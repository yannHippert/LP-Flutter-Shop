import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';

void showScaffoldMessage(BuildContext context, String text,
    {SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: infoMessageDuration,
      action: action,
    ),
  );
}
