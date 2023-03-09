import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/Utilities/constants.dart';
import 'package:flutter_sweater_shop/Utilities/messenger.dart';
import 'package:flutter_sweater_shop/redux/actions/authentication.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  final _storage = const FlutterSecureStorage();
  final iconSize = 32.0;

  const SettingsPage({super.key});

  void _onLogout(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(LogoutAction());
    Future.wait([
      _storage.delete(key: emailKey),
      _storage.delete(key: passwordKey),
    ]).then(
      (_) => showScaffoldMessage(
          context, AppLocalizations.of(context)!.user_loggedout),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserInfo>(
      converter: (store) => store.state.userInfo,
      builder: (context, userInfo) => SettingsList(
        sections: [
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.account),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.account_circle, size: iconSize),
                title: Text(AppLocalizations.of(context)!.email),
                value: Text(userInfo.email),
              ),
              SettingsTile(
                leading: Icon(Icons.logout, size: iconSize),
                title: Text(AppLocalizations.of(context)!.logout),
                onPressed: _onLogout,
              )
            ],
          ),
        ],
      ),
    );
  }
}
