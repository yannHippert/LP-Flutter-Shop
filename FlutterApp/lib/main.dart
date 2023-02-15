import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
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
            labelLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
    );
  }
}
