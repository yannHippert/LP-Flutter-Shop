import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Grid extends StatelessWidget {
  final List<Widget> widgets;
  double rowGap = 5.0;
  double columnGap = 5.0;
  int columnCount;
  int _rowCount = 0;

  Grid({super.key, required this.widgets, this.columnCount = 3}) {
    _rowCount = (widgets.length / columnCount).ceil();
  }

  Column _getGrid() {
    List<Widget> rows = [];
    for (var i = 0; i < _rowCount; i++) {
      rows.add(_getRow(i));
      if (i != _rowCount - 1) {
        rows.add(SizedBox(
          height: rowGap,
        ));
      }
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: rows);
  }

  Row _getRow(int rowIndex) {
    int startIndex = rowIndex * columnCount;
    List<Widget> rowWidgets = [];
    for (var i = startIndex;
        i < widgets.length && i < startIndex + columnCount;
        i++) {
      rowWidgets.add(widgets.elementAt(i));
      if (i < widgets.length - 1 && i < startIndex + columnCount - 1) {
        rowWidgets.add(SizedBox(
          width: columnGap,
        ));
      }
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 5.0,
        ),
        child: _getGrid());
  }
}
