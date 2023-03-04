import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Widgets/no_entries_display.dart';
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
    store.dispatch(fetchWishlist(completer));
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
      "An error occured while loading the wishlist!",
    );
  }

  void _removeFromWishlist(ShoppingItem item) {
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(removeWishlistItem(item, completer));
    completer.future.then(
      (_) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Product removed from wishlist'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
              label: 'UNDO', onPressed: () => _addToWishlist(item)),
        ),
      ),
    );
  }

  void _addToWishlist(ShoppingItem item) {
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addWishlistItem(item, completer));
    try {
      completer.future.then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added to cart'),
            duration: Duration(seconds: 2),
          ),
        ),
      );
    } on ApiException catch (e) {
      _onError(e);
    }
  }

  void _addToBasket(ShoppingItem item) {
    Completer completer = Completer();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(addBasketItem(item, completer));
    try {
      completer.future.then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product added to cart'),
            duration: Duration(seconds: 2),
          ),
        ),
      );
    } on ApiException catch (e) {
      _onError(e);
    }
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
          content: Text("An error occurred while loading the whishlist!"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<ShoppingItem>>(
      onInit: _fetchProducts,
      converter: (store) => store.state.whishlist,
      builder: (context, whishlist) {
        if (_isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (whishlist.isEmpty) {
          return const NoEntriesDisplay(
            iconData: Icons.star_border,
            text: "No products in your wishlist",
          );
        }
        return Scaffold(
          body: ListView.builder(
            itemCount: whishlist.length,
            itemBuilder: (context, index) {
              final whishlistItem = whishlist[index];
              return InkWell(
                  onTap: () => _navigateToProductPage(whishlistItem.id),
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Remove from wishlist",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      // Background for swiping right
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Add from basket",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                    // drag to the left to delete
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        _removeFromWishlist(whishlistItem);
                      } else {
                        _addToBasket(whishlistItem);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  whishlistItem.name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  currencyFormatter.format(whishlistItem.price),
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
                                    imageUrl: whishlistItem.image,
                                    color: whishlistItem.productColor?.color)),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}
