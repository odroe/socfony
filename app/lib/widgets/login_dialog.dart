import 'package:flutter/cupertino.dart';
import 'package:socfony/theme.dart';

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
          CupertinoTextField(
            prefix: const CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text('+86'),
              onPressed: null,
            ),
            placeholder: '手机号码',
            clearButtonMode: OverlayVisibilityMode.editing,
            keyboardType: TextInputType.number,
            keyboardAppearance: theme.brightness,
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: const Text('登录'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<dynamic> show() => showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => this,
        barrierDismissible: false,
      );
}
