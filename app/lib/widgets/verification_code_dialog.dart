import 'package:flutter/cupertino.dart';

import '../theme.dart';

class VerificationCodeDialog<T> extends StatelessWidget {
  final BuildContext context;
  final String? title;
  final String? doneButtonText;
  final String? phoneNumber;
  final bool? authorization;
  final Future<T> Function(String) onDone;

  VerificationCodeDialog.authorization({
    Key? key,
    required this.context,
    this.title,
    this.doneButtonText,
    required this.onDone,
    this.phoneNumber,
  })  : authorization = true,
        super(key: key);

  VerificationCodeDialog.phoneNumber({
    Key? key,
    required this.context,
    this.title,
    this.doneButtonText,
    required this.onDone,
    required this.phoneNumber,
  })  : authorization = false,
        super(key: key);

  String get convertTitle => title ?? '验证码';
  String get convertDoneButtonText => doneButtonText ?? '验证';

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(convertTitle),
      content: Column(
        children: [
          const Text('验证码已发送到你的手机'),
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: _controller,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            placeholder: '请输入验证码',
            keyboardType: TextInputType.number,
            autofocus: true,
            suffix: _VerificationCodeDialogFetchButton(
              authorization: authorization,
              phoneNumber: phoneNumber,
            ),
            maxLength: 6,
          ),
        ],
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text(convertDoneButtonText),
          onPressed: () async {
            final T result = await onDone(_controller.text);
            Navigator.of(context).pop<T>(result);
          },
        ),
      ],
    );
  }

  Future<T?> show() => showCupertinoDialog<T>(
        context: context,
        builder: (BuildContext context) => this,
        barrierDismissible: false,
      );
}

class _VerificationCodeDialogFetchButton extends StatefulWidget {
  final String? phoneNumber;
  final bool? authorization;

  const _VerificationCodeDialogFetchButton({
    Key? key,
    required this.phoneNumber,
    required this.authorization,
  })  : assert(authorization == true || (phoneNumber != null)),
        super(key: key);

  @override
  __VerificationCodeDialogFetchButtonState createState() =>
      __VerificationCodeDialogFetchButtonState();
}

class __VerificationCodeDialogFetchButtonState
    extends State<_VerificationCodeDialogFetchButton> {
  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData theme = AppTheme.of(context);

    return CupertinoButton(
      padding: const EdgeInsets.only(right: 12),
      child: Text('重新获取',
          style: theme.textTheme.footnote.copyWith(color: theme.primaryColor)),
      onPressed: () {},
    );
  }
}
