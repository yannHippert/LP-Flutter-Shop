class ProductSize {
  final String name;

  ProductSize({required this.name});

  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(name: json['name']);
  }

  @override
  bool operator ==(other) => other is ProductSize && other.name == name;

  @override
  int get hashCode => name.hashCode;

  Map<String, dynamic> toJson() => {'name': name};
}
