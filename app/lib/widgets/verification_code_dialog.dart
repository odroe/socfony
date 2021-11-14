import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:socfony/services/verification_code_service.dart';

import '../theme.dart';
import 'card_wrapper.dart';

class VerificationCodeDialog<T> extends StatelessWidget {
  final BuildContext context;
  final String? title;
  final String? doneButtonText;
  final String? phoneNumber;
  final void Function(String, void Function()) onDone;

  VerificationCodeDialog.authorization({
    Key? key,
    required this.context,
    this.title,
    this.doneButtonText,
    required this.onDone,
  })  : phoneNumber = null,
        super(key: key);

  VerificationCodeDialog.phoneNumber({
    Key? key,
    required this.context,
    this.title,
    this.doneButtonText,
    required this.onDone,
    required this.phoneNumber,
  }) : super(key: key);

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
          CardWrapper(
            padding: EdgeInsets.zero,
            child: CupertinoTextField(
              controller: _controller,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              placeholder: '请输入验证码',
              keyboardType: TextInputType.number,
              autofocus: true,
              suffix: _VerificationCodeDialogFetchButton(
                phoneNumber: phoneNumber,
              ),
              maxLength: 6,
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.none,
                ),
              ),
            ),
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
          onPressed: () => onVerification(context),
        ),
      ],
    );
  }

  void onVerification(BuildContext context) {
    if (_controller.text.length != 6) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('验证码错误'),
          content: const Text('请输入正确的验证码'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }

    onDone(_controller.text, () => Navigator.of(context).pop(_controller.text));
  }

  Future<T?> show() async {
    final onCloseSendingDialog = showSendingDialog(context);
    final onSend = createSendHandler(context, phoneNumber);

    try {
      await onSend();
      onCloseSendingDialog();
    } catch (e) {
      onCloseSendingDialog();
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('验证码发送失败'),
          content: const Text('请稍后再试'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );

      return null;
    }

    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) => this,
      barrierDismissible: false,
    );
  }

  static Future<void> Function() createSendHandler(BuildContext context,
      [String? phoneNumber]) {
    return () => VerificationCodeService(context).send(phoneNumber);
  }

  static void Function() showSendingDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => const CupertinoAlertDialog(
        title: Text('验证码发送中...'),
        content: CupertinoActivityIndicator(),
      ),
    );

    return () => Navigator.of(context).pop();
  }
}

class _VerificationCodeDialogFetchButton extends StatefulWidget {
  final String? phoneNumber;

  const _VerificationCodeDialogFetchButton({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  __VerificationCodeDialogFetchButtonState createState() =>
      __VerificationCodeDialogFetchButtonState();
}

class __VerificationCodeDialogFetchButtonState
    extends State<_VerificationCodeDialogFetchButton> {
  Timer? _timer;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CupertinoThemeData theme = AppTheme.of(context);
    return CupertinoButton(
      padding: const EdgeInsets.only(right: 12),
      child: Text(
        _countdown == 0 ? '重新获取' : '$_countdown s',
        style: theme.textTheme.footnote.copyWith(
          color: theme.primaryColor,
        ),
      ),
      onPressed: _countdown == 0 ? () => _fetch(context) : null,
    );
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_countdown == 0) {
        timer.cancel();
        return;
      }
      setState(() {
        _countdown--;
      });
    });
  }

  void _fetch(BuildContext context) async {
    final onCloseSendingDialog =
        VerificationCodeDialog.showSendingDialog(context);
    final onSend =
        VerificationCodeDialog.createSendHandler(context, widget.phoneNumber);

    try {
      _startCountdown();
      await onSend();
      onCloseSendingDialog();
    } catch (e) {
      onCloseSendingDialog();
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('验证码发送失败'),
          content: const Text('请稍后再试'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
