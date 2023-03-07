import 'package:flutter/material.dart';

class ProductColor implements Comparable {
  final String name;
  final int r;
  final int g;
  final int b;

  ProductColor({
    required this.name,
    required this.r,
    required this.g,
    required this.b,
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
        name: json['name'],
        r: json['r'] as int,
        g: json['g'] as int,
        b: json['b'] as int);
  }

  Color get color => Color.fromRGBO(r, g, b, 1);

  @override
  bool operator ==(other) => other is ProductColor && other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  int compareTo(other) =>
      other is ProductColor ? name.compareTo(other.name) : 0;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'r': r,
      'g': g,
      'b': b,
    };
  }
}
