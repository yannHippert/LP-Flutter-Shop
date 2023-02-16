import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Components/product_card.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Pages/product_page.dart';
import 'package:flutter_sweater_shop/redux/actions.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductListPage> {
  static const sidePadding = 20.0;
  static const itemGap = 10.0;

  double get screenWidth {
    return MediaQuery.of(context).size.width - 20;
  }

  int get columnCount {
    return max(1, (screenWidth / 150).floor());
  }

  double get elementWidth {
    double width =
        (screenWidth - 2 * sidePadding - ((columnCount - 1) * itemGap)) /
            columnCount;
    return width;
  }

  void _onTap(Product product) {
    product.isSelected = !product.isSelected;
    StoreProvider.of<AppState>(context).dispatch(UpdateProductAction(product));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProductPage(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Product>>(
        converter: (store) => store.state.products,
        builder: (context, List<Product> vm) => GridView.count(
            padding: const EdgeInsets.all(sidePadding),
            shrinkWrap: true,
            crossAxisSpacing: itemGap,
            mainAxisSpacing: itemGap,
            crossAxisCount: columnCount,
            childAspectRatio: 0.9,
            children: vm
                .map(
                  (Product product) => GestureDetector(
                    onTap: () => _onTap(product),
                    child: ProductCard(
                      product: product,
                      width: elementWidth,
                    ),
                  ),
                )
                .toList()));
  }
}
