import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socfony/routes/app_routes.dart';

import '../../lib/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        automaticallyImplyLeading: true,
        middle: Text('登录'),
      ),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 36),
            child: Text(
              '登录你的账号',
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 34,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              '你登录时输入的手机号码如果没有注册 Socfony 账号，则会在验证完成后自动为你创建账号。',
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.all(24).copyWith(bottom: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppTheme.cardBackgroundColor.resolveFrom(context),
            ),
            child: CupertinoTextField(
              keyboardType: TextInputType.number,
              decoration: const BoxDecoration(),
              prefix: Text(
                '+86',
                style: CupertinoTheme.of(context).textTheme.textStyle,
              ),
              suffix: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  size: 36,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.verificationCode);
                },
              ),
              autofocus: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(
                    CupertinoIcons.circle,
                    size: 18,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        const TextSpan(text: '需要同意'),
                        TextSpan(
                          text: '《服务协议》',
                          style: TextStyle(
                              color: CupertinoTheme.of(context).primaryColor),
                        ),
                        const TextSpan(text: '和'),
                        TextSpan(
                          text: '《隐私政策》',
                          style: TextStyle(
                              color: CupertinoTheme.of(context).primaryColor),
                        ),
                      ],
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .textStyle
                          .copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: CupertinoColors.systemGrey,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
