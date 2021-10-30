import 'package:flutter/widgets.dart';

class TapBlankSpaceCollapseKeyboard extends StatelessWidget {
  final Widget child;

  const TapBlankSpaceCollapseKeyboard({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () => collapseKeyboardHandler(context),
    );
  }

  void collapseKeyboardHandler(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
