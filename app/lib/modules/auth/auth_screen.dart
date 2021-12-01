import 'dart:async';

import 'package:app/configuration.dart';
import 'package:app/grpc.dart';
import 'package:app/framework.dart';
import 'package:app/modules/auth/auth_store.dart';
import 'package:app/utils/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  final BuildContext context;

  const AuthScreen(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _AuthController(),
      child: const _AuthPage(),
    );
  }

  Future<AuthStore?> show() {
    return Navigator.of(context).push<AuthStore>(MaterialPageRoute<AuthStore>(
      builder: (_) => this,
      fullscreenDialog: true,
    ));
  }
}

class _AuthController with ChangeNotifier {
  String phone = '';
  String otp = '';
  bool agreement = false;

  void onPhoneChanged(String phone) {
    this.phone = phone;
    notifyListeners();
  }

  void onOtpChanged(String otp) {
    this.otp = otp;
    notifyListeners();
  }

  void onAgreementChanged(bool? agreement) {
    this.agreement = agreement ?? false;
    notifyListeners();
  }
}

class _AuthPage extends StatelessWidget {
  const _AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        children: const <Widget>[
          _Logo(),
          SizedBox(height: 36),
          _PhoneNumberInput(),
          SizedBox(height: 24),
          _OtpInput(),
          SizedBox(height: 36),
          _SubmitButton(),
          SizedBox(height: 12),
          _Agreement(),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  double get size => 64;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      child: ClipRRect(
        child: Image.asset('assets/socfony.png'),
        borderRadius: BorderRadius.circular(size),
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<_AuthController>();

    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '手机号码',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 21),
        prefixIcon: const TextButton(
          child: Text('+86'),
          onPressed: null,
        ),
      ),
      onChanged: controller.onPhoneChanged,
    );
  }
}

class _OtpInput extends StatelessWidget {
  const _OtpInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<_AuthController>();

    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '验证码',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide.none,
        ),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 21),
        suffixIcon: const _SendOtpButton(),
      ),
      onChanged: controller.onOtpChanged,
    );
  }
}

class _SendOtpButton extends StatefulWidget {
  const _SendOtpButton({Key? key}) : super(key: key);

  @override
  State<_SendOtpButton> createState() => _SendOtpButtonState();
}

class _SendOtpButtonState extends State<_SendOtpButton> {
  Timer? timer;
  int counter = 0;
  bool isSending = false;

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 按钮样式
    final ButtonStyle style = ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.only(right: 24),
      ),
    );

    // 按钮文字
    String text = isSending ? '发送中...' : '发送验证码';
    if (!isSending && counter > 0) {
      text = '${counter}s';
    }

    // 事件
    void Function()? onPressed;
    if ((timer == null || !timer!.isActive) && !isSending) {
      onPressed = onSendOtp;
    }

    return TextButton(
      child: Text(text),
      style: style,
      onPressed: onPressed,
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
          String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );

  void onSendOtp() async {
    if (isSending || timer != null && timer!.isActive) {
      return;
    }

    final String phone = context.read<_AuthController>().phone;
    if (phone.isEmpty) {
      snackBar('请输入手机号码');
      return;
    } else if (validateChinaPhone(phone) == false) {
      snackBar('请输入正确的手机号码');
      return;
    }

    setState(() {
      isSending = true;
    });

    final request = StringValue()..value = chinaPhoneWrapper(phone);
    try {
      // 发送验证码
      await VerificationCodeMutationClient(channel).send(request);

      // 创建计时器
      createTimer();
    } catch (e) {
      snackBar(e is GrpcError ? e.message ?? '发送失败' : e.toString());
    } finally {
      setState(() {
        isSending = false;
      });
    }
  }

  void createTimer() {
    // 清除旧的计时器
    timer?.cancel();

    // 设置新的计时周期单位秒
    setState(() {
      counter = 60;
    });

    // 创建新的计时器
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter--;
      });

      if (counter == 0) {
        timer.cancel();
      }
    });
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final Widget child = isSubmitting
        ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
              strokeWidth: 2,
            ),
          )
        : const Text('登录');

    return ElevatedButton(
      onPressed: onSubmit,
      child: child,
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }

  void onSubmit() async {
    if (isSubmitting) {
      return;
    }

    final controller = context.read<_AuthController>();
    final phone = controller.phone;
    final otp = controller.otp;

    if (phone.isEmpty) {
      snackBar('请输入手机号码');
      return;
    } else if (validateChinaPhone(phone) == false) {
      snackBar('请输入正确的手机号码');
      return;
    } else if (otp.isEmpty) {
      snackBar('请输入验证码');
      return;
    } else if (controller.agreement == false) {
      snackBar('需要同意《用户协议》和《隐私政策》');
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final request = CreateAccessTokenRequest()
        ..phone = chinaPhoneWrapper(phone)
        ..code = otp;
      final AccessTokenEntity response =
          await AccessTokenMutationClient(channel).create(request);

      // 创建 Auth store
      final AuthStore authStore = AuthStore(response);

      // 持久化本地存储
      await authStore.save();

      // 储存到状态储存器中
      store.write<AuthStore>(authStore);

      // 返回上一个页面
      Navigator.of(context).pop<AuthStore>(authStore);
    } catch (e) {
      snackBar(e is GrpcError ? e.message ?? '登录失败' : e.toString());
    } finally {
      setState(() {
        isSubmitting = false;
      });
    }
  }

  snackBar(String message) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
}

class _Agreement extends StatelessWidget {
  const _Agreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.zero),
    );
    final agreement = context.select<_AuthController, bool>(
        (_AuthController controller) => controller.agreement);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: agreement,
          onChanged: context.read<_AuthController>().onAgreementChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        const Text('同意'),
        TextButton(
          child: const Text('《用户协议》'),
          onPressed: () {},
          style: style,
        ),
        const Text('和'),
        TextButton(
          child: const Text('《隐私政策》'),
          onPressed: () {},
          style: style,
        ),
      ],
    );
  }
}
