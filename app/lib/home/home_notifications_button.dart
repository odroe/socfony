import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeNotificationsButton extends StatelessWidget {
  const HomeNotificationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        // TODO: implement
      },
    );
  }
}
