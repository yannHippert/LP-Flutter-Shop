import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/Pages/basket_page.dart';
import 'package:flutter_sweater_shop/Pages/orders_list_page.dart';
import 'package:flutter_sweater_shop/Pages/products_list_page.dart';
import 'package:flutter_sweater_shop/Pages/account_page.dart';
import 'package:flutter_sweater_shop/Utilities/notification.dart';
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
    },
    {
      "icon": Icons.shopping_bag,
      "label": "Orders",
      "widget": OrderListPage(),
    },
    {
      "icon": Icons.shopping_cart,
      "label": "Basket",
      "widget": BasketPage(),
    },
    {
      "icon": Icons.account_circle,
      "label": "Account",
      "widget": AccountPage(),
    },
  ];

  Future<List<String>> _readFromStorage() async {
    String email = await _storage.read(key: "KEY_EMAIL") ?? "";
    String password = await _storage.read(key: "KEY_PASSWORD") ?? "";
    return (email == "" || password == "") ? [] : [email, password];
  }

  void _showWelcomeBackMessage() {
    showSuccessNotification(
      context,
      AppLocalizations.of(context)!.welcome_back,
    );
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  List<BottomNavigationBarItem> getNavIcons() {
    return _pages
        .map((e) =>
            BottomNavigationBarItem(icon: Icon(e["icon"]), label: e["label"]))
        .toList();
  }

  void _checkLogin(Store store) async {
    Completer completer = Completer();
    var loginInfo = await _readFromStorage();
    if (loginInfo.isNotEmpty) {
      store.dispatch(
        authenticate(loginInfo[0], loginInfo[1], completer),
      );
      try {
        await completer.future;
        _showWelcomeBackMessage();
      } on ApiException catch (e) {
        onError(e);
      }
    }
  }

  void onError(e) {
    print(e);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages.elementAt(_selectedIndex)["label"]),
        actions: <Widget>[
          StoreConnector<AppState, UserInfo>(
              onInit: _checkLogin,
              converter: (store) => store.state.userInfo,
              builder: (context, UserInfo vm) => vm.isLoggedIn
                  ? const Icon(Icons.vpn_key)
                  : const Icon(Icons.lock)),
          const SizedBox(width: 16)
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages.map<Widget>((e) => e["widget"]).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getNavIcons(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
