import 'package:flutter/material.dart';

import '../../components/unfocus.dart';
import 'components/account_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Unfocus(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Join Socfony'),
        ),
        body: ListView(
          children: const [
            _SocfonyLoginScreenLogo(),
            LoginAccountField(),
          ],
        ),
      ),
    );
  }
}

class _SocfonyLoginScreenLogo extends StatelessWidget {
  const _SocfonyLoginScreenLogo();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/login_screen_logo.png',
        height: 200,
      ),
    );
  }
}
