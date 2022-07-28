import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'moment_picked_images.dart';

class AddMomentImageButton extends ConsumerWidget {
  const AddMomentImageButton({Key? key}) : super(key: key);

  // Create a new image picker.
  ImagePicker get picker => ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch picked images count.
    final int count =
        ref.watch(pickedImagesProvider.select((value) => value.length));
    // If count is 9, return empty widget.
    if (count >= 9) {
      return const SizedBox.shrink();
    }

    // Get current screen width.
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Center(
        child: OutlinedButton(
          onPressed: () => _pickImages(context, ref.read),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: width * 0.2),
          ),
          child: const Text('添加图片'),
        ),
      ),
    );
  }

  /// Pick images from gallery.
  void _pickImages(BuildContext context, Reader reader) async {
    // unfource focus.
    FocusScope.of(context).unfocus();

    // Pick images.
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 9999,
      maxHeight: 9999,
    );

    // If result is null, return.
    if (file == null) {
      return;
    }

    // Add images to provider.
    reader(pickedImagesProvider.state).update((state) => [...state, file.path]);
  }
}
