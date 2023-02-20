import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Widgets/product_card.dart';
import 'package:flutter_sweater_shop/Exceptions/ApiException.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Pages/product_page.dart';
import 'package:flutter_sweater_shop/redux/actions/product.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware.dart';
import 'package:redux/redux.dart';

const double sidePadding = 20;
const double itemGap = 10;
const double iconSize = 48;

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductListPage> {
  bool _isLoading = true;

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
    //StoreProvider.of<AppState>(context).dispatch(UpdateProductAction(product));
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProductPage(product: product)),
    );
  }

  void _fetchProducts(Store store) async {
    Completer completer = Completer();
    store.dispatch(
      fetchProducts(completer),
    );
    try {
      await completer.future;
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onError(ApiException e) {
    print(e);
  }

  Widget _buildNoEntries() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.receipt, size: iconSize),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.no_products),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Product>>(
        onInit: _fetchProducts,
        converter: (store) => store.state.products,
        builder: (context, List<Product> products) {
          if (_isLoading) {
            return GridView.count(
              padding: const EdgeInsets.all(sidePadding),
              shrinkWrap: true,
              crossAxisSpacing: itemGap,
              mainAxisSpacing: itemGap,
              crossAxisCount: columnCount,
              childAspectRatio: 0.9,
              children: List.generate(
                10,
                (index) => SkeletonProductCard(width: elementWidth),
              ),
            );
          }
          if (products.isEmpty) return _buildNoEntries();
          return GridView.count(
              padding: const EdgeInsets.all(sidePadding),
              shrinkWrap: true,
              crossAxisSpacing: itemGap,
              mainAxisSpacing: itemGap,
              crossAxisCount: columnCount,
              childAspectRatio: 0.9,
              children: [
                SkeletonProductCard(width: elementWidth),
                ...products
                    .map(
                      (Product product) => GestureDetector(
                        onTap: () => _onTap(product),
                        child: ProductCard(
                          product: product,
                          width: elementWidth,
                        ),
                      ),
                    )
                    .toList(),
              ]);
        });
  }
}
