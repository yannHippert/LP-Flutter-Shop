class ProductSize {
  final int id;
  final String name;

  ProductSize({required this.id, required this.name});

  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(id: json['id'] as int, name: json['name']);
  }

  @override
  bool operator ==(other) => other is ProductSize && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
