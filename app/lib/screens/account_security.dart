import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart' show GrpcError;
import 'package:provider/provider.dart';
import 'package:socfony/services/auth_service.dart';
import 'package:socfony/services/state_service.dart';
import 'package:socfony/src/protobuf/socfony.pb.dart';
import 'package:socfony/src/protobuf/socfony.pbgrpc.dart';
import 'package:socfony/theme.dart';
import 'package:socfony/widgets/card_wrapper.dart';
import 'package:socfony/widgets/login_dialog.dart';
import 'package:socfony/widgets/verification_code_dialog.dart';

import '../grpc.dart';

class AccountSecurityScreen extends StatelessWidget {
  final BuildContext context;

  const AccountSecurityScreen(this.context, {Key? key}) : super(key: key);

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
              onPressed: () {
                _EditPhoneDialog(context).show();
              },
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

class _EditPhoneDialog extends StatelessWidget {
  final BuildContext context;

  const _EditPhoneDialog(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('更换受信任的电话号码'),
      content: const Text('更换受信任的电话号码需要先验证你当前的受信任的手机号码'),
      actions: [
        CupertinoDialogAction(
          child: const Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: const Text('确定'),
          onPressed: onSendVerificationCode,
        ),
      ],
    );
  }

  onSendVerificationCode() async {
    await VerificationCodeDialog.authorization(
            context: context, onDone: onDoneVerificationCode)
        .show();
    Navigator.of(context).pop();
  }

  onDoneVerificationCode(String code, void Function() onClose) async {
    await _EditPhoneScreen(
      context: context,
      code: code,
    ).show();
    onClose();
  }

  void show() {
    showCupertinoDialog(
      context: context,
      builder: (context) => this,
      barrierDismissible: true,
    );
  }
}

class _EditPhoneScreen extends StatelessWidget {
  final String code;
  final BuildContext context;

  _EditPhoneScreen({Key? key, required this.context, required this.code})
      : super(key: key);

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('更换受信任的电话号码'),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          CardWrapper.divider(
            dividerMargin: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('+86 中国大陆'),
                  Icon(CupertinoIcons.forward),
                ],
              ),
              CupertinoTextField(
                autofocus: true,
                controller: _phoneController,
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  border: Border(),
                ),
                placeholder: '电话号码',
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, top: 4),
            child: Text('验证码将发送到此号码。',
                style: AppTheme.of(context)
                    .textTheme
                    .footnote
                    .resolveFrom(context, secondary: true)),
          ),
          CardWrapper(
            margin: const EdgeInsets.only(top: 24),
            padding: EdgeInsets.zero,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('验证新号码并更换'),
              onPressed: () => _onHandler(_phoneController.text),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onHandler(String phone) async {
    final newPhoneCode = await VerificationCodeDialog.phoneNumber(
      context: context,
      phoneNumber: phone,
      onDone: (String code, void Function() onClose) =>
          _onDoneVerificationCode(phone, code, onClose),
    ).show();

    if (newPhoneCode != null) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _onDoneVerificationCode(
      String phone, String code, void Function() onClose) async {
    final request = UserUpdatePhoneRequest()
      ..oldPhoneCode = this.code
      ..phone = '+86' + phone
      ..code = code;
    final callOptions = context.read<AuthService>().callOptions;

    try {
      final response = await UserMutationClient(channel)
          .updatePhone(request, options: callOptions);

      context
          .read<StateService>()
          .update<UserEntity>(response, (element) => element.id == response.id);
    } catch (e) {
      _showAlert(e is GrpcError ? e.message! : e.toString());
      return;
    }

    onClose();
  }

  void _showAlert(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('错误'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> show() {
    return Navigator.of(context).push<void>(
      CupertinoPageRoute<void>(
        builder: (context) => this,
      ),
    );
  }
}
