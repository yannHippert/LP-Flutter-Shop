class PropertyPrice<T> {
  final double _priceVariation;
  final T _property;

  PropertyPrice(double priceVariation, T property)
      : _priceVariation = priceVariation,
        _property = property;

  double get priceVariation => _priceVariation;

  T get property => _property;
}
