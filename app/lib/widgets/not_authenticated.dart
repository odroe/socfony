import 'package:flutter/cupertino.dart';
import 'package:socfony/theme.dart';
import 'package:socfony/widgets/login_dialog.dart';

class NotAuthenticated extends StatelessWidget {
  const NotAuthenticated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '你还没有登录哦',
            style: AppTheme.of(context).textTheme.headline,
          ),
          CupertinoButton(
            child: const Text('登录'),
            onPressed: () => LoginDialog(context: context).show(),
          ),
        ],
      ),
    );
  }
}
