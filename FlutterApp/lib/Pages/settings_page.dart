import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sweater_shop/redux/actions.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  final _storage = const FlutterSecureStorage();

  const SettingsPage({super.key});

  void _onLogout(BuildContext context) async {
    StoreProvider.of<AppState>(context).dispatch(LogoutAction());
    await _storage.delete(key: "KEY_EMAIL");
    await _storage.delete(key: "KEY_PASSWORD");
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: Text('Common'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Language'),
              value: Text('English'),
              onPressed: (context) => print("Pressed"),
            ),
          ],
        ),
        SettingsSection(title: Text("Account"), tiles: <SettingsTile>[
          SettingsTile(
              title: Text("Logout", textAlign: TextAlign.center),
              onPressed: _onLogout)
        ]),
      ],
    );
  }
}
