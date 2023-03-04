import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware/wishlist.dart';
import 'package:flutter_sweater_shop/redux/middleware/basket.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/notification.dart';
import 'package:flutter_sweater_shop/Widgets/filtered_image.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'product_page.dart';
import 'package:redux/redux.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  bool _isLoading = true;

  void _fetchProducts(Store store) async {
    Completer completer = Completer();
    store.dispatch(
      fetchWishlist(completer),
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
      "An error occured while loading the products!",
    );
  }

  void _removeFromWishlist(ShoppingItem item) {
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(removeWishlistItem(item, completer));
  }

  void _addToWishlist(ShoppingItem item) {
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addWishlistItem(item, completer));
  }

  void _addToBasket(ShoppingItem item) {
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addBasketItem(item, completer));
  }

  void _navigateToProductPage(String productId) {
    ApiClient.fetchProduct(productId).then((product) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(product: product),
        ),
      );
    }).catchError((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred while loading the product!"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<ShoppingItem>>(
      onInit: _fetchProducts,
      converter: (store) => store.state.favorites,
      builder: (context, favorites) {
        if (_isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (favorites.isEmpty) {
          return const Center(
            child: Text("No products in your wishlist"),
          );
        } else {
          return Scaffold(
            body: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return InkWell(
                    onTap: () => _navigateToProductPage(product.id),
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40.0,
                            ),
                            SizedBox(width: 20.0),
                          ],
                        ),
                      ),
                      secondaryBackground: Container(
                        // Background for swiping right
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(width: 20.0),
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ],
                        ),
                      ),
                      // drag to the left to delete
                      onDismissed: (direction) {
                        setState(() {
                          _removeFromWishlist(product);
                        });
                        if (direction == DismissDirection.startToEnd) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Product deleted'),
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  setState(() {
                                    _addToWishlist(product);
                                  });
                                },
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            _addToBasket(product);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product added to cart'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    '€${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            SizedBox(
                              width: 90,
                              height: 90,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: FilteredImage(
                                      imageUrl: product.image,
                                      color: product.productColor?.color)),
                            ),
                          ],
                        ),
                      ),
                    ));
              },
            ),
          );
        }
      },
    );
  }
}
