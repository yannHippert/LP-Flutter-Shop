import 'package:flutter/material.dart';

class ProductColor implements Comparable {
  final String _name;
  final int _r;
  final int _g;
  final int _b;
  final double _a;

  ProductColor.fromColor({
    required String name,
    required Color color,
  })  : _name = name,
        _r = color.red,
        _g = color.green,
        _b = color.blue,
        _a = 1;

  ProductColor.fromRGBA(
      {required String name,
      required int r,
      required int g,
      required int b,
      double a = 1})
      : _name = name,
        _r = r,
        _g = g,
        _b = b,
        _a = a;

  String get name {
    return _name;
  }

  Color get color {
    return Color.fromRGBO(_r, _g, _b, _a);
  }

  @override
  int compareTo(dynamic other) {
    return _name.compareTo(other.name);
  }
}
