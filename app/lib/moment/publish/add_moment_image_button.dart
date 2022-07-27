import 'package:flutter/material.dart';

class AddMomentImageButton extends StatelessWidget {
  const AddMomentImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get current screen width.
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Center(
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: width * 0.2),
          ),
          child: const Text('添加图片'),
        ),
      ),
    );
  }
}
