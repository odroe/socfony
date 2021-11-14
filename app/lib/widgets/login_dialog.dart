import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'package:provider/provider.dart';

import '../theme.dart';
import '../services/auth_service.dart';
import '../src/protobuf/socfony.pb.dart';
import 'card_wrapper.dart';
import 'verification_code_dialog.dart';

class _LoginDialogController with ChangeNotifier {
  final BuildContext context;

  _LoginDialogController(this.context);

  String? phoneNumber;
  bool isAgreement = false;

  void setPhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  bool get isValidPhoneNumber => phoneNumber?.length == 11;

  void setAgreement(bool value) {
    isAgreement = value;
    notifyListeners();
  }

  bool get isValidAgreement => isAgreement;

  void onLogin(
    String code,
    void Function() onCloseVerificationCodeDialog,
  ) async {
    // Show login alert
    showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
        title: Text('登录中'),
        content: CupertinoActivityIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      final AuthService auth = context.read<AuthService>();
      await auth.login('+86' + phoneNumber!, code);
      Navigator.of(context).pop();

      if (auth.isAuthenticated) {
        onCloseVerificationCodeDialog();
        Navigator.of(context).pop();
      }
    } catch (e) {
      Navigator.of(context).pop();
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('错误'),
          content: Text(e is GrpcError ? e.message! : e.toString()),
        ),
        barrierDismissible: false,
      );
    }
  }
}

class LoginDialog extends StatelessWidget {
  final BuildContext context;

  const LoginDialog({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('登录'),
      content: Column(
        children: const <Widget>[
          Text('你登录时输入的手机号码如果没有注册 Socfony 账号，则会在验证完成后自动为你创建账号。'),
          SizedBox(height: 12),
          CardWrapper(
            padding: EdgeInsets.zero,
            child: _PhoneNumberTextField(),
          ),
          SizedBox(height: 12),
          _Agreement(),
          // Divider.title(
          //   title: '或者',
          //   margin: const EdgeInsets.symmetric(vertical: 12),
          // ),
        ],
      ),
    );
  }

  Future<dynamic> show() => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => ChangeNotifierProvider(
          create: (BuildContext context) => _LoginDialogController(context),
          child: this,
        ),
        barrierDismissible: true,
      );
}

class _PhoneNumberTextField extends StatelessWidget {
  const _PhoneNumberTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData theme = AppTheme.of(context);

    return CupertinoTextField(
      prefix: const CupertinoButton(
        padding: EdgeInsets.zero,
        child: Text('+86'),
        onPressed: null,
      ),
      suffix: CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(
          CupertinoIcons.arrow_right_circle_fill,
          size: 36,
        ),
        onPressed: () => onGotoVerificationCode(context),
      ),
      placeholder: '手机号码',
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.number,
      keyboardAppearance: theme.brightness,
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.none,
        ),
      ),
      onChanged: (String value) => onChangePhoneNumber(context, value),
    );
  }

  void onChangePhoneNumber(BuildContext context, String value) {
    context.read<_LoginDialogController>().setPhoneNumber(value);
  }

  void onGotoVerificationCode(BuildContext context) {
    final bool isValid = validate(context);
    if (isValid) {
      VerificationCodeDialog.phoneNumber(
        context: context,
        phoneNumber: context.read<_LoginDialogController>().phoneNumber,
        onDone: context.read<_LoginDialogController>().onLogin,
      ).show();
    }
  }

  bool validate(BuildContext context) {
    return validatePhoneNumber(context) && validateAgreement(context);
  }

  bool validatePhoneNumber(BuildContext context) {
    final controller = context.read<_LoginDialogController>();

    if (controller.isValidPhoneNumber) {
      return true;
    }

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(
          controller.phoneNumber == null || controller.phoneNumber!.isEmpty
              ? '请输入手机号码'
              : '请输入正确的手机号码',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );

    return false;
  }

  bool validateAgreement(BuildContext context) {
    final bool isValidAgreement =
        context.read<_LoginDialogController>().isValidAgreement;

    if (isValidAgreement) {
      return true;
    }

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text('需要同意相关协议才能继续'),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );

    return false;
  }
}

class _Agreement extends StatelessWidget {
  const _Agreement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData theme = AppTheme.of(context);

    return Row(
      children: [
        const _AgremmentButton(),
        const SizedBox(width: 4),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: '需要同意'),
                  TextSpan(
                    text: '《用户协议》',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                  const TextSpan(text: '和'),
                  TextSpan(
                    text: '《隐私政策》',
                    style: TextStyle(color: theme.primaryColor),
                  ),
                ],
              ),
              style: theme.textTheme.caption2.resolveFrom(context),
            ),
          ),
        ),
      ],
    );
  }
}

class _AgremmentButton extends StatelessWidget {
  const _AgremmentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.select<_LoginDialogController, bool>(
        (controller) => controller.isAgreement);

    return GestureDetector(
      child: Icon(
        value ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.circle,
        size: 16,
      ),
      onTap: () => onToggle(context),
    );
  }

  void onToggle(BuildContext context) {
    final _LoginDialogController controller =
        context.read<_LoginDialogController>();
    controller.setAgreement(!controller.isAgreement);
  }
}
