import 'package:flutter/material.dart';

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
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('个人资料'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              EditUserProfileScreen.show(context);
            },
          ),
          const ListTile(
            title: Text('账户与安全'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(thickness: 6),
          const ListTile(
            title: Text('主题'),
            trailing: Icon(Icons.chevron_right),
          ),
          const Divider(thickness: 6),
          const ListTile(
            title: Text('清除缓存'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            title: Text('关于 Socfony'),
            trailing: Icon(Icons.chevron_right),
          ),
          TextButton(
            child: const Text('退出账号'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
