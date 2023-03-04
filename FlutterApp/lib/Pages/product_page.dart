import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Models/product_size.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/notification.dart';
import 'package:flutter_sweater_shop/Widgets/filtered_image.dart';
import 'package:flutter_sweater_shop/Widgets/loading_overlay.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware/basket.dart';
import 'package:flutter_sweater_shop/redux/middleware/wishlist.dart';
import 'dart:math' as math;

class ProductPage extends StatefulWidget {
  final VariableProduct product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isLoading = false;
  ProductColor? _selectedColor;
  ProductSize? _selectedSize;

  VariableProduct get product => widget.product;

  @override
  void initState() {
    super.initState();

    if (product.isColorable) {
      setState(() => _selectedColor = product.variants.elementAt(0).color);
    }

    if (product.isSizeable) {
      setState(() => _selectedSize = product.variants.elementAt(0).size);
    }
  }

  void _addToBasket() async {
    setState(() => _isLoading = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(
      addBasketItem(
          ShoppingItem.fromProduct(
            product,
            _selectedSize,
            _selectedColor,
          ),
          completer),
    );
    try {
      await completer.future;
    } on ApiException catch (e) {
      _onError(e);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _addToWishlist() async {
    setState(() => _isLoading = true);
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(
      addWishlistItem(
          ShoppingItem.fromProduct(product, _selectedSize, _selectedColor),
          completer),
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
    showErrorNotification(
      context,
      "An error occured while connection to the server!",
    );
  }

  Widget _buildColorSelection() {
    if (product.isColorable) {
      return Wrap(
        spacing: 10,
        children: product.colors
            .map(
              (color) => OutlinedButton(
                onPressed: () => setState(() {
                  _selectedColor = color;
                }),
                style: OutlinedButton.styleFrom(
                    side: _selectedColor == color
                        ? const BorderSide(width: 3, color: Colors.white)
                        : null,
                    backgroundColor: color.color),
                child: Text(
                  color.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
            .toList(),
      );
    }
    return const SizedBox.shrink();
  }

  bool _isPossibleSize(
    ProductSize? size,
    ProductColor? color,
  ) {
    return product.getVariant(size, color) != null;
  }

  Widget _buildSizeSelection() {
    if (product.isSizeable) {
      return Wrap(
        spacing: 10,
        children: product.sizes.map((size) {
          bool isPossible = _isPossibleSize(size, _selectedColor);
          return Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              SizedBox(
                width: 60,
                child: OutlinedButton(
                  onPressed: isPossible
                      ? () => setState(() {
                            _selectedSize = size;
                          })
                      : null,
                  style: OutlinedButton.styleFrom(
                      side: _selectedSize == size
                          ? const BorderSide(width: 3, color: Colors.white)
                          : isPossible
                              ? null
                              : const BorderSide(width: 3, color: Colors.red),
                      backgroundColor: Colors.grey),
                  child: Text(
                    size.name,
                    style: TextStyle(
                        color: isPossible ? Colors.white : Colors.white54),
                  ),
                ),
              ),
              isPossible
                  ? const SizedBox.shrink()
                  : Transform.rotate(
                      angle: math.pi / 8,
                      child: Container(
                        width: 60,
                        height: 3,
                        color: Colors.red,
                      ),
                    ),
            ],
          );
        }).toList(),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildAddToBasketButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        onPressed: _isPossibleSize(_selectedSize, _selectedColor)
            ? _addToBasket
            : null,
        icon: const Icon(Icons.add_shopping_cart),
        label: Text(AppLocalizations.of(context)!.add_to_basket),
      ),
    );
  }

  Widget _buildAddToWishlistButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        onPressed: _isPossibleSize(_selectedSize, _selectedColor)
            ? _addToWishlist
            : null,
        icon: const Icon(Icons.star),
        label: Text(AppLocalizations.of(context)!.add_to_wishlist),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton.icon(
        onPressed: () => {},
        icon: const Icon(Icons.login),
        label: Text(AppLocalizations.of(context)!.login_to_shop),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.product),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: FilteredImage(
                        imageUrl: product.image,
                        width: 200,
                        height: 200,
                        color: _selectedColor?.color,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        currencyFormatter.format(
                            product.getPrice(_selectedSize, _selectedColor)),
                      ),
                    ],
                  ),
                  _buildSizeSelection(),
                  _buildColorSelection(),
                  StoreConnector<AppState, UserInfo>(
                      converter: (store) => store.state.userInfo,
                      builder: (context, UserInfo userInfo) {
                        return userInfo.isLoggedIn
                            ? Column(
                                children: [
                                  _buildAddToBasketButton(),
                                  _buildAddToWishlistButton(),
                                ],
                              )
                            : _buildLoginButton();
                      }),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        _isLoading ? const LoadingOverlay() : const SizedBox.shrink(),
      ],
    );
  }
}
