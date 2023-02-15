class Product {
  final String _id;
  final String _name;
  final double _price;
  final String _image;
  final List<String> _colors;
  final List<String> _sizes;

  Product(
      {required id,
      required name,
      required price,
      required image,
      required colors,
      required sizes})
      : _id = id,
        _name = name,
        _price = price,
        _image = image,
        _colors = colors,
        _sizes = sizes;

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  double get price {
    return _price;
  }

  String get image {
    return _image;
  }

  List<String> get colors {
    return _colors;
  }

  List<String> get sizes {
    return _sizes;
  }
}
