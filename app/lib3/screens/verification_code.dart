import 'package:flutter/cupertino.dart';

import '../../lib/theme.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: const Text('输入验证码'),
        trailing: SizedBox(
          height: 28,
          child: CupertinoButton.filled(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Text('登录'),
            onPressed: () {},
          ),
        ),
      ),
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.all(24).copyWith(bottom: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppTheme.cardBackgroundColor.resolveFrom(context),
            ),
            child: CupertinoTextField(
              keyboardType: TextInputType.number,
              decoration: const BoxDecoration(),
              prefix: Text(
                '验证码',
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
              autofocus: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: SizedBox(
              width: double.infinity,
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: '如未收到验证码，请点击'),
                    TextSpan(
                      text: '重新获取',
                      style: TextStyle(
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: CupertinoColors.systemGrey,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
