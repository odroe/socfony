import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socfony/services/auth_service.dart';
import 'package:socfony/services/state_service.dart';
import 'package:socfony/src/protobuf/socfony.pb.dart';
import 'package:socfony/src/protobuf/socfony.pbgrpc.dart';
import 'package:socfony/theme.dart';
import 'package:socfony/widgets/card_wrapper.dart';
import 'package:socfony/widgets/login_dialog.dart';

import '../grpc.dart';

class AccountSecurity extends StatelessWidget {
  final BuildContext context;

  const AccountSecurity(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('账户安全'),
      ),
      child: _CurrentAccountLoading(),
    );
  }

  Future<T?> go<T>() {
    return LoginDialog(context: context).canAuthenticate<T>(
      show: true,
      onAuthenticated: () {
        return Navigator.of(context).push<T>(
          CupertinoPageRoute<T>(
            builder: (context) => this,
          ),
        );
      },
    );
  }
}

class _CurrentAccountLoading extends StatelessWidget {
  const _CurrentAccountLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = context.select<AuthService, String>(
      (service) => service.entity!.userId,
    );
    final UserEntity? initialData =
        context.read<StateService>().find<UserEntity>(
              (element) => element.id == id,
            );

    if (initialData != null) {
      return const _PageView();
    }

    return FutureBuilder(
      initialData: initialData,
      future: fetch(context, id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const _PageView();
        }

        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }

  Future<UserEntity> fetch(BuildContext context, String id) async {
    final request = UserFindOneRequest()..id = id;
    final callOption = context.read<AuthService>().callOptions;
    final response =
        await UserQueryClient(channel).findOne(request, options: callOption);

    context
        .read<StateService>()
        .update<UserEntity>(response, (element) => element.id == id);

    return response;
  }
}

class _PageView extends StatelessWidget {
  const _PageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                '受信任的电话号码',
                style: AppTheme.of(context)
                    .textTheme
                    .subheadline
                    .resolveFrom(context),
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('更换'),
              onPressed: () {},
            ),
          ],
        ),
        const _PhoneCard(),
        Padding(
          padding: const EdgeInsets.only(left: 6, top: 4),
          child: Text(
            '受信任的电话号码用于在登录时验证您的身份。',
            style: AppTheme.of(context)
                .textTheme
                .footnote
                .resolveFrom(context, secondary: true),
          ),
        ),
      ],
    );
  }
}

class _PhoneCard extends StatelessWidget {
  const _PhoneCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = context.read<AuthService>().entity!.userId;
    final phone = context.select<StateService, String>(
      (service) => service
          .find<UserEntity>(
            (element) => element.id == id,
          )!
          .phone,
    );
    return CardWrapper(
      margin: EdgeInsets.zero,
      child: Text(phone),
    );
  }
}
