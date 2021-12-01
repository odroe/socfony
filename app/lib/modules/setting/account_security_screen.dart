import 'package:app/configuration.dart';
import 'package:app/framework.dart';
import 'package:app/grpc.dart' hide ConnectionState;
import 'package:app/modules/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  const _AccountName({ Key? key }) : super(key: key);

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
      subtitle: username !=null && username.isNotEmpty ?  Text(username) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _AccountNameUpdate.show(context),
    );
  }
}

class _AccountNameUpdate extends StatefulWidget {
  const _AccountNameUpdate({ Key? key }) : super(key: key);

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
    final String? username = store.read<UserEntity>(
      (entity) => entity.id == userId,
    )!.name;
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
        children: <Widget> [
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
              contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
              padding:
                  MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
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
    final String? oldName = store.read<UserEntity>(
      (entity) => entity.id == userId,
    )?.name;
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
  const _UserPhone({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.read<AuthStore>()!.userId;
    final String? phone = context.store.read<UserEntity>(
      (entity) => entity.id == userId,
    )?.phone;

    return ListTile(
      title: const Text('手机号码'),
      subtitle: phone != null && phone.isNotEmpty ? Text(phone) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _UserPhoneUpdate.show(context),
    );
  }
}

class _UserPhoneUpdate extends StatefulWidget {
  const _UserPhoneUpdate({ Key? key }) : super(key: key);

  @override
  __UserPhoneUpdateState createState() => __UserPhoneUpdateState();

  static void show(BuildContext context) async {
    final bool? hasNext = await _PreSendPhoneCodeDialog.show(context);
    if (hasNext == true) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const _UserPhoneUpdate(),
        ),
      );
    }
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
          const SizedBox(height: 12),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: const [
                  TextField(
                    decoration: InputDecoration(
                      labelText: '当前手机验证码',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: '新手机号码',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: '新手机验证码',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreSendPhoneCodeDialog extends StatefulWidget {
  const _PreSendPhoneCodeDialog({ Key? key }) : super(key: key);

  @override
  __PreSendPhoneCodeDialogState createState() => __PreSendPhoneCodeDialogState();

  static Future<bool?> show(BuildContext context) {
    return Future.value(true);
    final String userId = context.store.read<AuthStore>()!.userId;
    final String? phone = context.store.read<UserEntity>(
      (entity) => entity.id == userId,
    )?.phone;
    if (phone == null || phone.isEmpty) {
      return Future.value(true);
    }

    return showDialog<bool>(
      context: context,
      builder: (context) => const _PreSendPhoneCodeDialog(),
    );
  }
}

class __PreSendPhoneCodeDialogState extends State<_PreSendPhoneCodeDialog> {
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('提示'),
      content: const Text('更换手机号码将发送验证码到你当前绑定的手机号码以此来确认您的身份。'),
      actions: _isSending
        ? [
          TextButton.icon(
            icon: const SizedBox.square(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
              dimension: 24,
            ),
            label: const Text('正在发送...'),
            onPressed: null,
          )
        ]
        : [
          TextButton(
            child: const Text('取消'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('确认'),
            onPressed: onSendOtp,
          ),
        ],
    );
  }

  void onSendOtp() async {
    setState(() {
      _isSending = true;
    });

    try {
      await VerificationCodeMutationClient(channel).send(
        StringValue(),
        options: store.read<AuthStore>()?.callOptions,
      );
      Navigator.of(context).pop<bool>(true);
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('提示'),
          content: Text(e is GrpcError ? e.message! : '未知错误'),
          actions: [
            TextButton(
              child: const Text('确认'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
