import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Utilities/notification.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
import 'package:flutter_sweater_shop/Widgets/product_card.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Pages/product_page.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware/product.dart';
import 'package:redux/redux.dart';

const double sidePadding = 20;
const double itemGap = 10;

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductListPage> {
  bool _isLoading = true;
  bool _isLoadingMore = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isBottom = _scrollController.position.pixels != 0;
        if (isBottom) loadMore();
      }
    });
  }

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

  void _onTap(VariableProduct product) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductPage(product: product)),
    );
  }

  void _fetchProducts(Store store) async {
    Completer completer = Completer();
    store.dispatch(fetchProducts(completer));
    try {
      await completer.future;
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }
  }

  void loadMore() async {
    setState(() => _isLoadingMore = true);
    final store = StoreProvider.of<AppState>(context);
    _fetchProducts(store);
  }

  void _onError(ApiException e) {
    showErrorNotification(
      context,
      "An error occured while loading the products!",
    );
  }

  Widget _buildNoEntries() {
    return NoEntriesDisplay(
      iconData: Icons.receipt,
      text: AppLocalizations.of(context)!.no_products,
    );
  }

  Widget _buildGrid(List<Widget> children, bool isSkeleton) {
    return GridView.count(
        controller: isSkeleton ? null : _scrollController,
        physics: isSkeleton
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(sidePadding),
        shrinkWrap: true,
        crossAxisSpacing: itemGap,
        mainAxisSpacing: itemGap,
        crossAxisCount: columnCount,
        childAspectRatio: 0.80,
        children: children);
  }

  Widget _buildContent(List<VariableProduct> products) {
    if (_isLoading) {
      return _buildGrid(
          List.generate(
              10, (index) => SkeletonProductCard(width: elementWidth)),
          true);
    }
    if (products.isEmpty) return _buildNoEntries();
    return _buildGrid([
      ...products
          .map(
            (VariableProduct product) => GestureDetector(
              onTap: () => _onTap(product),
              child: ProductCard(
                product: product,
                width: elementWidth,
              ),
            ),
          )
          .toList(),
      ...List.generate(10, (index) => SkeletonProductCard(width: elementWidth)),
    ], false);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<VariableProduct>>(
      onInit: _fetchProducts,
      converter: (store) => store.state.products,
      builder: (context, List<VariableProduct> products) => Column(
        children: [
          Expanded(child: _buildContent(products)),
          _isLoadingMore
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                    Text(AppLocalizations.of(context)!.loading_products)
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
