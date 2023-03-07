import 'dart:io';

class ProductCategory {
  final String id;
  final double categoryPrice;
  final Map<String, String> translations;

  ProductCategory({
    required this.id,
    required this.categoryPrice,
    required this.translations,
  });

  factory ProductCategory.fromJson(String pid, Map<String, dynamic> json) {
    double categoryPrice = (json["categoryPrice"] is int)
        ? (json["categoryPrice"] as int).toDouble()
        : (json["categoryPrice"] as double);

    Map<String, String> translations =
        Map<String, String>.from(json["translations"]);

    return ProductCategory(
      id: pid,
      categoryPrice: categoryPrice,
      translations: translations,
    );
  }

  String get name {
    String lang = Platform.localeName.substring(0, 2);
    if (translations.containsKey(lang)) {
      return translations[lang]!;
    } else {
      return translations["en"]!;
    }
  }
}
