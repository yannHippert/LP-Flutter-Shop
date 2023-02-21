import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

void _showNotification(
  BuildContext context,
  String text, {
  Color backgroundColor = Colors.green,
  IconData iconData = Icons.check,
}) {
  showSimpleNotification(
    Row(children: [
      Icon(
        iconData,
        color: Colors.white,
      ),
      const SizedBox(width: 10.0),
      Text(
        text,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    ]),
    background: backgroundColor,
  );
}

void showSuccessNotification(
  BuildContext context,
  String text, {
  IconData iconData = Icons.check,
}) {
  _showNotification(
    context,
    text,
    iconData: iconData,
    backgroundColor: Colors.green,
  );
}

void showErrorNotification(
  BuildContext context,
  String text, {
  IconData iconData = Icons.clear,
}) {
  _showNotification(
    context,
    text,
    iconData: iconData,
    backgroundColor: Colors.red,
  );
}
