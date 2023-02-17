import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sweater_shop/Exceptions/ApiException.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/Pages/orders_list_page.dart';
import 'package:flutter_sweater_shop/Pages/products_list_page.dart';
import 'package:flutter_sweater_shop/Pages/account_page.dart';
import 'package:flutter_sweater_shop/redux/actions.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:overlay_support/overlay_support.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _storage = const FlutterSecureStorage();
  static const iconSize = 150.0;
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
      "icon": Icons.account_circle,
      "label": "Account",
      "widget": AccountPage(),
    },
  ];

  Future<List<String>> _readFromStorage() async {
    String email = await _storage.read(key: "KEY_EMAIL") ?? "";
    String password = await _storage.read(key: "KEY_PASSWORD") ?? "";
    if (email == "" || password == "") return [];
    return [email, password];
  }

  void _onLoginSuccess(String email) {
    if (context == null) return;
    showSimpleNotification(
      Row(children: const [
        Icon(
          Icons.check,
          color: Colors.white,
        ),
        SizedBox(width: 10.0),
        Text(
          "Welcome back!",
          style: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ]),
      background: Colors.green,
    );
    StoreProvider.of<AppState>(context).dispatch(LoginAction(email));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> getNavIcons() {
    return _pages
        .map((e) =>
            BottomNavigationBarItem(icon: Icon(e["icon"]), label: e["label"]))
        .toList();
  }

  void onError(e) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages.elementAt(_selectedIndex)["label"]),
        actions: <Widget>[
          StoreConnector<AppState, UserInfo>(
              onInit: (store) async {
                Completer completer = Completer();
                var loginInfo = await _readFromStorage();
                if (loginInfo.isNotEmpty) {
                  store.dispatch(
                      authenticate(loginInfo[0], loginInfo[1], completer));
                }
                try {
                  await completer.future;
                } on ApiException catch (e) {
                  onError(e);
                }
              },
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
