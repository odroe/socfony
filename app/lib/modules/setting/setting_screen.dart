import 'package:flutter/material.dart';

import 'account_security_screen.dart';
import 'edit_user_profile_screen.dart';

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
        elevation: 1.0,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
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
          const SizedBox(height: 16),
          const Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: ListTile(
              title: Text('主题'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
