import 'package:app/modules/auth/auth_store.dart';
import 'package:app/modules/main/main_screen.dart';
import 'package:app/src/store/store_context.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_security_screen.dart';
import 'edit_user_profile_screen.dart';
import 'theme_screen.dart';

class SettingScreen extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
        fullscreenDialog: false,
      ),
    );
  }

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 8.0),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(),
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    title: const Text('个人资料'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      EditUserProfileScreen.show(context);
                    },
                  ),
                  ListTile(
                    title: const Text('账户与安全'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      AccountSecurityScreen.show(context);
                    },
                  ),
                ],
              ).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            shape: const RoundedRectangleBorder(),
            elevation: 0,
            margin: EdgeInsets.zero,
            child: ListTile(
              title: const Text('主题'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ThemeScreen.show(context);
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(),
            margin: EdgeInsets.zero,
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: const [
                  ListTile(
                    title: Text('清除缓存'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    title: Text('关于 Socfony'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ],
              ).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              child: const Text('退出账号'),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                context.store.write<UniqueKey>(UniqueKey());
                context.store.delete<AuthStore>();
                prefs.remove(AuthStore.key);
              },
            ),
          ),
        ],
      ),
    );
  }
}
