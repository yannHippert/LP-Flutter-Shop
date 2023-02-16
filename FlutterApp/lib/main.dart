import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sweater_shop/Utilities/fixtures.dart';
import 'package:flutter_sweater_shop/navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/redux/actions.dart';
import 'package:flutter_sweater_shop/redux/reducer.dart';
import 'package:overlay_support/overlay_support.dart';

import 'redux/app_state.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Store<AppState> _store = Store<AppState>(updateProductsReducer,
      initialState:
          AppState(products: getPorudctList(), orders: getOrderList()));
  final _storage = const FlutterSecureStorage();
  final GlobalKey _key = GlobalKey();

  Future<String?> _readFromStorage() async {
    String email = await _storage.read(key: "KEY_EMAIL") ?? "";
    String password = await _storage.read(key: "KEY_PASSWORD") ?? "";
    if (email == "" || password == "") return null;

    //final response = await autheticate(email: email, password: password);
    //if (response.statusCode == 200) {
    int statusCode =
        await Future.delayed(const Duration(seconds: 2), () => 200);
    if (statusCode == 200) {
      return email;
    }
    return null;
  }

  void _onLoginSuccess(String email) {
    BuildContext? context = _key.currentContext;
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String? email = await _readFromStorage();
      if (email != null) {
        _onLoginSuccess(email);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      key: _key,
      store: _store,
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'Ugly Sweater Shop',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: Brightness.dark,
            textSelectionTheme:
                TextSelectionThemeData(selectionColor: Colors.blue.shade900),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(),
              displayLarge: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              labelLarge:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ).apply(
              bodyColor: Colors.white,
              fontFamily: 'OpenSans',
            ),
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const BottomNavBar(),
        ),
      ),
    );
  }
}
