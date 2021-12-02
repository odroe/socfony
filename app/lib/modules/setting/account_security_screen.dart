import 'dart:async';

import 'package:app/configuration.dart';
import 'package:app/framework.dart';
import 'package:app/grpc.dart' hide ConnectionState;
import 'package:app/modules/auth/auth_store.dart';
import 'package:app/utils/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
          const SizedBox(height: 6),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: const <Widget>[
                  _AccountName(),
                  _UserPhone(),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountName extends StatelessWidget {
  const _AccountName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.select<AuthStore, String>(
      (store) => store?.userId,
    )!;
    final String? username = context.store.select<UserEntity, String>(
      (store) => store?.name,
      where: (entity) => entity.id == userId,
    );

    return ListTile(
      title: const Text('账户'),
      subtitle: username != null && username.isNotEmpty ? Text(username) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _AccountNameUpdate.show(context),
    );
  }
}

class _AccountNameUpdate extends StatefulWidget {
  const _AccountNameUpdate({Key? key}) : super(key: key);

  @override
  __AccountNameUpdateState createState() => __AccountNameUpdateState();

  static void show(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _AccountNameUpdate(),
      ),
    );
  }
}

class __AccountNameUpdateState extends State<_AccountNameUpdate> {
  late final TextEditingController _controller;

  String? errorText;

  @override
  void initState() {
    super.initState();

    final String userId = store.read<AuthStore>()!.userId;
    final String? username = store
        .read<UserEntity>(
          (entity) => entity.id == userId,
        )!
        .name;
    _controller = TextEditingController(text: username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('设置账户名'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          const SizedBox(height: 24),
          TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(
              hintText: '请输入账户名',
              helperText: '账户名是你在系统中自定义的唯一标识',
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            ),
            maxLength: 12,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\w+]'))
            ],
            onSubmitted: (_) => onSubmit,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            child: const Text('保存'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    final String userId = store.read<AuthStore>()!.userId;
    final String? oldName = store
        .read<UserEntity>(
          (entity) => entity.id == userId,
        )
        ?.name;
    final String newName = _controller.text;

    if (oldName == newName) {
      Navigator.of(context).pop();
      return;
    } else if (newName.isEmpty) {
      setState(() => errorText = '账户名不能为空');
      return;
    } else if (newName.length > 12) {
      setState(() => errorText = '账户名不能超过12个字符');
      return;
    }

    try {
      final response = await UserMutationClient(channel).updateName(
        StringValue()..value = newName,
        options: store.read<AuthStore>()?.callOptions,
      );

      store.write<UserEntity>(
        response,
        where: (entity) => entity.id == userId,
      );
    } catch (e) {
      setState(() => errorText = e is GrpcError ? e.message : '未知错误');
      return;
    }

    Navigator.of(context).pop();
  }
}

class _UserPhone extends StatelessWidget {
  const _UserPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.read<AuthStore>()!.userId;
    final String? phone = context.store.select<UserEntity, String>(
      (entity) => entity?.phone,
      where: (entity) => entity.id == userId,
    );

    return ListTile(
      title: const Text('手机号码'),
      subtitle: phone != null && phone.isNotEmpty ? Text(phone) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _UserPhoneUpdate.show(context),
    );
  }
}

class _UserPhoneUpdateController with ChangeNotifier {
  final TextEditingController oldPhoneOtpController = TextEditingController();
  final TextEditingController newPhoneOtpController = TextEditingController();
  final TextEditingController newPhoneController = TextEditingController();

  bool isSubmitting = false;

  void setIsSubmitting(bool value) {
    isSubmitting = value;
    notifyListeners();
  }

  UserUpdatePhoneRequest get request => UserUpdatePhoneRequest()
    ..oldPhoneCode = oldPhoneOtpController.text
    ..code = newPhoneOtpController.text
    ..phone = chinaPhoneWrapper(newPhoneController.text);
}

class _UserPhoneUpdate extends StatefulWidget {
  const _UserPhoneUpdate({Key? key}) : super(key: key);

  @override
  __UserPhoneUpdateState createState() => __UserPhoneUpdateState();

  static void show(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          child: const _UserPhoneUpdate(),
          create: (_) => _UserPhoneUpdateController(),
        ),
      ),
    );
  }
}

class __UserPhoneUpdateState extends State<_UserPhoneUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('新手机号码'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Text('原号码验证码'),
              title: TextField(
                enabled:
                    !context.read<_UserPhoneUpdateController>().isSubmitting,
                controller: context
                    .read<_UserPhoneUpdateController>()
                    .oldPhoneOtpController,
                decoration: const InputDecoration(
                  hintText: '请输入验证码',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                    gapPadding: 0,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              trailing: const _UpdateUserPhoneSendOtpButton(false),
            ),
          ),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Text('新的手机号码'),
              title: TextField(
                controller: context
                    .read<_UserPhoneUpdateController>()
                    .newPhoneController,
                enabled:
                    !context.read<_UserPhoneUpdateController>().isSubmitting,
                decoration: const InputDecoration(
                  hintText: '请输入新手机号码',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                    gapPadding: 0,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Text('新号码验证码'),
              title: TextField(
                controller: context
                    .read<_UserPhoneUpdateController>()
                    .newPhoneOtpController,
                enabled:
                    !context.read<_UserPhoneUpdateController>().isSubmitting,
                decoration: const InputDecoration(
                  hintText: '请输入验证码',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              trailing: const _UpdateUserPhoneSendOtpButton(true),
            ),
          ),
          const _UpdateUserPhoneButton(),
        ],
      ),
    );
  }
}

class _UpdateUserPhoneSendOtpButton extends StatefulWidget {
  const _UpdateUserPhoneSendOtpButton(this.isNewPhone, {Key? key})
      : super(key: key);

  final bool isNewPhone;

  @override
  State<_UpdateUserPhoneSendOtpButton> createState() =>
      _UpdateUserPhoneSendOtpButtonState();
}

class _UpdateUserPhoneSendOtpButtonState
    extends State<_UpdateUserPhoneSendOtpButton> {
  bool isSending = false;
  int counter = 0;
  Timer? timer;

  @override
  void dispose() {
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
    String text = isSending
        ? '发送中...'
        : timer == null
            ? '发送验证码'
            : '重新获取';
    if (!isSending && counter > 0) {
      text = '${counter}s';
    }

    // 事件
    void Function()? onPressed;
    if ((timer == null || !timer!.isActive) && !isSending) {
      onPressed = onSendOtp;
    }
    final bool isSubmitting = context.select<_UserPhoneUpdateController, bool>(
      (controller) => controller.isSubmitting,
    );
    if (isSubmitting) {
      onPressed = null;
    }

    return TextButton(
      child: Text(text),
      style: style,
      onPressed: onPressed,
    );
  }

  String get phone => widget.isNewPhone
      ? context.read<_UserPhoneUpdateController>().newPhoneController.text
      : '';

  void onSendOtp() async {
    if (isSending) return;
    if (widget.isNewPhone && phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请输入新手机号码'),
        ),
      );
      return;
    } else if (widget.isNewPhone && validateChinaPhone(phone) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('请输入正确的手机号码'),
        ),
      );
      return;
    }

    final request = StringValue();
    if (widget.isNewPhone) {
      request.value = chinaPhoneWrapper(phone);
    }

    setState(() {
      isSending = true;
    });

    try {
      await VerificationCodeMutationClient(channel)
          .send(request, options: store.read<AuthStore>()?.callOptions);
      createTimer();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e is GrpcError ? e.message! : '发送验证码失败'),
        ),
      );
    }

    setState(() {
      isSending = false;
    });
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

class _UpdateUserPhoneButton extends StatelessWidget {
  const _UpdateUserPhoneButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSubmitting = context.select<_UserPhoneUpdateController, bool>(
      (controller) => controller.isSubmitting,
    );

    final Widget child = isSubmitting
        ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
              strokeWidth: 2,
            ),
          )
        : const Text('修改');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(
        top: 36,
      ),
      child: ElevatedButton(
        onPressed: () => onSubmit(context),
        child: child,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 12)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }

  onSubmit(BuildContext context) async {
    final _UserPhoneUpdateController controller =
        context.read<_UserPhoneUpdateController>();
    controller.setIsSubmitting(true);
    final String userId = context.store.read<AuthStore>()!.userId;

    try {
      final response = await UserMutationClient(channel).updatePhone(
        controller.request,
        options: context.store.read<AuthStore>()?.callOptions,
      );
      context.store.write<UserEntity>(
        response,
        where: (entity) => entity.id == userId,
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e is GrpcError ? e.message! : '修改失败'),
        ),
      );
      controller.setIsSubmitting(false);
    }
  }
}
