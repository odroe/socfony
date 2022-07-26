import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'account_phone_provider.dart';
import 'update_account_phone_screen.dart';

/// Account security screen.
class AccountSecurityScreen extends StatelessWidget {
  const AccountSecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('账户安全'),
      ),
      body: ListView(
        children: const <Widget>[
          SizedBox(height: 24),
          _SecurityPhoneListTile(),
        ],
      ),
    );
  }
}

class _SecurityPhoneListTile extends ConsumerWidget {
  const _SecurityPhoneListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch phone.
    final String? phone = ref.watch(accountPhoneProvider);

    // Phone has is empty.
    final bool hasEmpty = phone == null || phone.isEmpty;

    return ListTile(
      leading: const Icon(Icons.security_update_good),
      title: Text(hasEmpty ? '手机号码' : phone),
      subtitle: const Text('手机号码将保护你的账号安全，用于登录、找回密码等操作'),
      trailing: TextButton(
        child: Text(hasEmpty ? '绑定' : '更换'),
        onPressed: () => _jumpToUpdateAccountPhoneScreen(context),
      ),
    );
  }

  /// Jump to update account phone screen.
  void _jumpToUpdateAccountPhoneScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const UpdateAccountPhoneScreen(),
    ));
  }
}
