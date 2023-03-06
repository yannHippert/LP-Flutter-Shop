import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/Pages/basket_page.dart';
import 'package:flutter_sweater_shop/Pages/orders_list_page.dart';
import 'package:flutter_sweater_shop/Pages/products_list_page.dart';
import 'package:flutter_sweater_shop/Pages/wishlist_page.dart';
import 'package:flutter_sweater_shop/Pages/account_page.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/middleware/authenticate.dart';
import 'package:redux/redux.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _storage = const FlutterSecureStorage();
  int _selectedIndex = 0;

  static const List _pages = [
    {
      "icon": Icons.list,
      "label": "Products",
      "widget": ProductListPage(),
      "needsLogin": false
    },
    {
      "icon": Icons.account_circle,
      "label": "Account",
      "widget": AccountPage(),
      "needsLogin": false
    },
    {
      "icon": Icons.star,
      "label": "Wishlist",
      "widget": WishListPage(),
      "needsLogin": true
    },
    {
      "icon": Icons.shopping_cart,
      "label": "Basket",
      "widget": BasketPage(),
      "needsLogin": true
    },
    {
      "icon": Icons.shopping_bag,
      "label": "Orders",
      "widget": OrderListPage(),
      "needsLogin": true
    },
  ];

  List<dynamic> _getPages(bool isLoggedIn) {
    return _pages
        .where(
          (element) =>
              !element["needsLogin"] || element["needsLogin"] == isLoggedIn,
        )
        .toList();
  }

  Future<List<String>> _readFromStorage() async {
    String email = await _storage.read(key: "KEY_EMAIL") ?? "";
    String password = await _storage.read(key: "KEY_PASSWORD") ?? "";
    return (email == "" || password == "") ? [] : [email, password];
  }

  void _showWelcomeBackMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.welcome_back),
        duration: infoMessageDuration,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  List<BottomNavigationBarItem> getNavIcons(bool isLoggedIn) {
    return _getPages(isLoggedIn)
        .map((e) => BottomNavigationBarItem(
              icon: Icon(e["icon"]),
              label: e["label"],
            ))
        .toList();
  }

  void _checkLogin(Store store) async {
    Completer completer = Completer();
    var loginInfo = await _readFromStorage();
    if (loginInfo.isNotEmpty) {
      store.dispatch(authenticate(loginInfo[0], loginInfo[1], completer));
      completer.future
          .then((value) => _showWelcomeBackMessage())
          .catchError(_handleError);
    }
  }

  void _handleError(Object? error, StackTrace stackTrace) {
    if (error is ApiException) {
      showScaffoldMessage(
          context, AppLocalizations.of(context)!.err_server_connection);
    } else {
      if (kDebugMode) print(stackTrace.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserInfo>(
      onInit: _checkLogin,
      converter: (store) => store.state.userInfo,
      builder: (context, UserInfo userInfo) => Scaffold(
        appBar: AppBar(
          title: Text(_pages.elementAt(_selectedIndex)["label"]),
          actions: [
            userInfo.isLoggedIn
                ? const Icon(Icons.vpn_key)
                : const Icon(Icons.lock),
            const SizedBox(width: 16)
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _getPages(userInfo.isLoggedIn)
              .map<Widget>((e) => e["widget"])
              .toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: getNavIcons(userInfo.isLoggedIn),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
