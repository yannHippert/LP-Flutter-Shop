import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_sweater_shop/redux/reducer.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:redux_thunk/redux_thunk.dart';

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
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
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
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              displayMedium: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              labelMedium: TextStyle(fontSize: 14),
              labelLarge: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
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
