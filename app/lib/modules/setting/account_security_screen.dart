import 'package:app/configuration.dart';
import 'package:app/framework.dart';
import 'package:app/grpc.dart' hide ConnectionState;
import 'package:app/modules/auth/auth_store.dart';
import 'package:flutter/material.dart';

class AccountSecurityScreen extends StatelessWidget {
  static void show(BuildContext context) {
    AuthStore.can(
      context,
      show: true,
      next: (_) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AccountSecurityScreen(),
        ),
      ),
    );
  }

  const AccountSecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.select<AuthStore, String>(
      (store) => store?.userId,
    )!;

    return FutureBuilder(
      initialData: userId,
      future: fetch(context, userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return const _AccountSecurityScreenScaffold();
      },
    );
  }

  Future<String?> fetch(BuildContext context, String userId) async {
    final request = UserFindOneRequest()..id = userId;
    final response = await UserQueryClient(channel).findOne(request,
        options: context.store.read<AuthStore>()?.callOptions);

    context.store.write<UserEntity>(
      response,
      where: (entity) => entity.id == userId,
    );

    return response.id;
  }
}

class _AccountSecurityScreenScaffold extends StatelessWidget {
  const _AccountSecurityScreenScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('账户与安全'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('账户'),
            subtitle: const Text('socfony'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            title: const Text('手机号码'),
            subtitle: const Text('+8617723308434'),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
