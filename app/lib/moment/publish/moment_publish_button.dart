import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'moment_content_text_field.dart';
import 'moment_picked_images.dart';

class MomentPublishButton extends ConsumerWidget {
  const MomentPublishButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: TextButton.icon(
        onPressed: callbackBuilder(context, ref),
        icon: const Icon(Icons.near_me),
        label: const Text('发布'),
      ),
    );
  }

  /// Build button on pressed callback.
  VoidCallback? callbackBuilder(BuildContext context, WidgetRef ref) {
    /// Read text field value.
    final String content = ref.watch(momentContentControllerProvider).text;

    /// Read picked images.
    final List<String> images = ref.watch(pickedImagesProvider);

    // If conten is empty, and no picked images, return null.
    if (content.isEmpty && images.isEmpty) {
      return null;
    }

    // return callback.
    return () => onCreateMoment(context, ref.read);
  }

  /// Create moment.
  void onCreateMoment(BuildContext context, Reader reader) {
    // Read text field value.
    final String content = reader(momentContentControllerProvider).text;
    // Read picked images.
    final List<String> images = reader(pickedImagesProvider);
    // Create moment.
    print('content: $content, images: $images');
  }
}
