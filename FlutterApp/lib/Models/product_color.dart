import 'package:flutter/material.dart';

class ProductColor implements Comparable {
  final int _id;
  final String _name;
  final int _r;
  final int _g;
  final int _b;
  final double _a;

  ProductColor.fromColor({
    required int id,
    required String name,
    required Color color,
  })  : _id = id,
        _name = name,
        _r = color.red,
        _g = color.green,
        _b = color.blue,
        _a = 1;

  ProductColor.fromRGBA(
      {required int id,
      required String name,
      required int r,
      required int g,
      required int b,
      double a = 1})
      : _id = id,
        _name = name,
        _r = r,
        _g = g,
        _b = b,
        _a = a;

  ProductColor.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'],
        _r = json['r'],
        _g = json['g'],
        _b = json['b'],
        _a = json['a'] ?? 1;

  int get id => _id;

  String get name => _name;

  Color get color => Color.fromRGBO(_r, _g, _b, _a);

  @override
  int compareTo(dynamic other) => _name.compareTo(other.name);
}
