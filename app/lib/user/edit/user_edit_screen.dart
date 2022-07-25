import 'package:flutter/material.dart';

class UserEditScreen extends StatelessWidget {
  const UserEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('账户信息'),
      ),
    );
  }
}
