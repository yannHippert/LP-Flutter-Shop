import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilteredImage extends StatelessWidget {
  final String imageUrl;
  double width;
  double height;
  Color? color;

  FilteredImage(
      {super.key,
      required this.imageUrl,
      this.width = double.infinity,
      this.height = double.infinity,
      this.color});

  Widget _applySaturationFilter(Color color, Widget widget) {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.saturation),
        child: widget);
  }

  Widget _applyHueFilter(Color color, Widget widget) {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(color.withAlpha(210), BlendMode.hue),
        child: widget);
  }

  @override
  Widget build(BuildContext context) {
    Widget image = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
    if (color != null) {
      return _applyHueFilter(color!, _applySaturationFilter(color!, image));
    }
    return image;
  }
}
