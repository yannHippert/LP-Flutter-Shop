import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final oCcy = NumberFormat.simpleCurrency(locale: "fr_EU");

  Product get product {
    return widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                product.image,
                width: 100,
              ),
            ),
            Row(
              children: [Text(product.name), Text(oCcy.format(product.price))],
            )
          ],
        ),
      ),
    );
  }
}
