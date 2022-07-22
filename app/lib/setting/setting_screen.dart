import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../about/about_screen.dart';
import '../about/application_name.dart';
import '../about/socfony_icon.dart';
import '../auth/auth_provider.dart';
import '../home/home_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('设置'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 24),
          // Account
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('账户', style: Theme.of(context).textTheme.bodySmall),
          ),
          ListTile(
            leading: const Icon(Icons.person_outlined),
            title: const Text('账户信息'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock_outlined),
            title: const Text('账户安全'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          // General
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('通用', style: Theme.of(context).textTheme.bodySmall),
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('主题颜色'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          // About
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('关于', style: Theme.of(context).textTheme.bodySmall),
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: const Text('用户协议'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.policy_outlined),
            title: const Text('隐私政策'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const _AboutTile(),
          const Divider(),
          // Logout
          const _LogoutButton(),
        ],
      ),
    );
  }
}

class _AboutTile extends StatelessWidget {
  const _AboutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SocfonyIcon(),
      title: ApplicationName(builder: _applicationNameTextBuilder),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _jumpToAboutScreen(context),
    );
  }

  /// Jump to socfony about page.
  void _jumpToAboutScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AboutScreen(),
      ),
    );
  }

  /// Build application name text.
  Text _applicationNameTextBuilder(
          BuildContext context, String applicationName) =>
      Text('关于$applicationName');
}

class _LogoutButton extends ConsumerWidget {
  const _LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double fifth = MediaQuery.of(context).size.width / 5;

    return Align(
      alignment: Alignment.center,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: fifth),
        ),
        icon: const Icon(Icons.logout),
        label: const Text('退出登录'),
        onPressed: () => _onLogout(context, ref.read),
      ),
    );
  }

  /// Logout handler
  void _onLogout(BuildContext context, Reader reader) async {
    // Push and remove jump to home screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );

    // Deleto access token from storage
    await destroyAccessToken();

    // Clean authenticated provider
    reader(authenticatedProvider).value = null;
  }
}
