import 'dart:async';

import 'dart:math';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
import 'package:flutter_sweater_shop/Widgets/product_card.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Pages/product_page.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/product_category.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware/category.dart';
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

  String _searchText = "";
  bool _didSearchChange = false;
  List<ProductCategory> _selectCategories = [];

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

  void _fetchProducts(Store store) {
    Completer completer = Completer();
    store.dispatch(fetchProducts(
      completer,
      searchText: _searchText,
      categories: _selectCategories,
    ));
    completer.future.onError(_handleError).whenComplete(() {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    });
  }

  void _fetchCategories(Store store) {
    Completer completer = Completer();
    store.dispatch(fetchCategories(completer));
    completer.future.onError(_handleError);
  }

  void loadMore() {
    setState(() => _isLoadingMore = true);
    final store = StoreProvider.of<AppState>(context);
    _fetchProducts(store);
  }

  void _handleError(Object? error, StackTrace stackTrace) {
    if (error is ApiException) {
      showScaffoldMessage(
        context,
        AppLocalizations.of(context)!.err_server_connection,
      );
    } else {
      if (kDebugMode) print(stackTrace.toString());
    }
  }

  Future<void> _openFilterDialog(List<ProductCategory> categories) async {
    await FilterListDialog.display<ProductCategory>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Select categories',
      height: 500,
      listData: categories,
      selectedListData: _selectCategories,
      choiceChipLabel: (item) => item!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.All, ControlButtonType.Reset],
      onItemSearch: (category, query) {
        _didSearchChange = true;
        _searchText = query;
        return true;
      },
      onApplyButtonClick: (list) {
        if (!_didSearchChange) _searchText = "";
        _didSearchChange = false;
        _selectCategories = List.from(list!);
        setState(() => _isLoading = true);
        _fetchProducts(StoreProvider.of<AppState>(context));
        Navigator.pop(context);
      },
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

  Widget _buildLoadingMore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
        Text(AppLocalizations.of(context)!.loading_products)
      ],
    );
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
    return Scaffold(
      body: Stack(
        children: [
          StoreConnector<AppState, List<VariableProduct>>(
            onInit: _fetchProducts,
            converter: (store) => store.state.products,
            builder: (context, List<VariableProduct> products) => Column(
              children: [
                Expanded(child: _buildContent(products)),
                _isLoadingMore ? _buildLoadingMore() : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: StoreConnector<AppState, List<ProductCategory>>(
        onInit: _fetchCategories,
        converter: (store) => store.state.categories,
        builder: (context, List<ProductCategory> categories) =>
            FloatingActionButton(
          onPressed: () => _openFilterDialog(categories),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.filter_list,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
