import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'moment_publish_provider.dart';

/// Will pop scope widget.
class PublishScreenWillPop extends ConsumerWidget {
  const PublishScreenWillPop({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context, ref.read),
      child: child,
    );
  }

  /// Will pop callback.
  Future<bool> _onWillPop(BuildContext context, Reader reader) async {
    final bool isPublishing = await reader(publishingProvider);

    // If publishing, show dialog.
    if (isPublishing) {
      final bool? state = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('提示'),
          content: const Text('正在发送动态，无法关闭发布页面。'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('知道了'),
            ),
          ],
        ),
      );

      return state ?? false;
    }

    // If not publishing, return true.
    return true;
  }
}
