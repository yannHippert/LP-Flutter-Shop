import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/Components/grid.dart';
import 'package:flutter_sweater_shop/Components/product_card.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Pages/product_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductListPage> {
  double get screenWidth {
    return MediaQuery.of(context).size.width - 20;
  }

  int get columnCount {
    return max(1, (screenWidth / 150).floor());
  }

  Iterable<int> range(int low, int high) sync* {
    for (int i = low; i < high; ++i) {
      yield i;
    }
  }

  Product product = Product(
      id: "123",
      name: "Sweater",
      price: 19.99,
      image: "https://picsum.photos/200",
      colors: ["Red", "Green"],
      sizes: ["S", "M", "L", "XL"]);

  List<Product> products = [];

  List<Widget> _getProductCards() {
    for (final _ in range(1, 20)) {
      products.add(product);
    }
    return products
        .map((Product product) => ProductCard(product: product))
        .toList();
  }

  void _onTap(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: GridView.count(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: columnCount,
          children: List.generate(
            25,
            (index) => (GestureDetector(
                onTap: () => _onTap(product),
                child: ProductCard(
                  product: product,
                  width:
                      screenWidth / columnCount - 20 - ((columnCount - 1) * 10),
                ))),
          ),
        ),
      ),
    );
  }
}
