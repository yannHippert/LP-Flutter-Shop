import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/Pages/login_page.dart';
import 'package:flutter_sweater_shop/Pages/settings_page.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccounPageState createState() => _AccounPageState();
}

class _AccounPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserInfo>(
        converter: (store) => store.state.userInfo,
        builder: (context, UserInfo vm) =>
            vm.isLoggedIn ? const SettingsPage() : const LoginPage());
  }
}
