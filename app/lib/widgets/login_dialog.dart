import 'package:flutter/cupertino.dart';

import '../theme.dart';
import 'card_wrapper.dart';
import 'verification_code_dialog.dart';

class LoginDialog extends StatelessWidget {
  final BuildContext context;

  const LoginDialog({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData theme = AppTheme.of(context);

    return CupertinoAlertDialog(
      title: const Text('登录'),
      content: Column(
        children: <Widget>[
          const Text('你登录时输入的手机号码如果没有注册 Socfony 账号，则会在验证完成后自动为你创建账号。'),
          const SizedBox(height: 12),
          CardWrapper(
            padding: EdgeInsets.zero,
            child: CupertinoTextField(
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
                onPressed: () {
                  VerificationCodeDialog.authorization(
                    context: context,
                    onDone: (value) async => value,
                  ).show();
                },
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
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(CupertinoIcons.circle, size: 16),
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
          ),
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
        builder: (BuildContext context) => this,
        barrierDismissible: true,
      );
}
