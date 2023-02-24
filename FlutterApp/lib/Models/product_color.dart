import 'package:flutter/material.dart';

class ProductColor implements Comparable {
  final String id;
  final String name;
  final int r;
  final int g;
  final int b;
  final double a;

  ProductColor(
      {required this.id,
      required this.name,
      required this.r,
      required this.g,
      required this.b,
      this.a = 1});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
        id: json['id'],
        name: json['name'],
        r: json['r'] as int,
        g: json['g'] as int,
        b: json['b'] as int);
  }

  Color get color => Color.fromRGBO(r, g, b, a);

  @override
  bool operator ==(other) => other is ProductColor && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  int compareTo(other) =>
      other is ProductColor ? name.compareTo(other.name) : 0;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'r': r,
      'g': g,
      'b': b,
      'a': a,
    };
  }
}
