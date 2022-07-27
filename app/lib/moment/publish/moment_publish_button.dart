import 'package:flutter/material.dart';

class MomentPublishButton extends StatelessWidget {
  const MomentPublishButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.near_me),
        label: const Text('发布'),
      ),
    );
  }
}
