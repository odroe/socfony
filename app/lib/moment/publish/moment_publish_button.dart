import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../../configure.dart';
import '../../minio.dart';
import '../../socfony_service.dart';
import 'moment_content_text_field.dart';
import 'moment_picked_images.dart';
import 'moment_publish_provider.dart';
import 'moment_title_text_field.dart';

class MomentPublishButton extends ConsumerWidget {
  const MomentPublishButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(publishingProvider)) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(right: 16),
          child: SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

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
  void onCreateMoment(BuildContext context, Reader reader) async {
    // Read title.
    final String title = reader(momentTitleControllerProvider).text;
    // Read text field value.
    final String content = reader(momentContentControllerProvider).text;
    // Read picked images.
    final List<String> images = reader(pickedImagesProvider);

    // Set loading state.
    reader(publishingProvider.state).state = true;

    try {
      // Upload images.
      final List<String> uploadedImages = await uploadImages(images);

      // Create moment request.
      final request = CreateMomentRequest()
        ..title = title
        ..content = content;
      request.images.addAll(uploadedImages);

      // TODO: Add to lists.
      final moment = await socfonyService.createMoment(request);

      // Navigate to moment detail page.
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      reader(publishingProvider.state).state = false;
      print(e);
    }
  }

  /// Upload images.
  Future<List<String>> uploadImages(List<String> images) async {
    final List<String> result = <String>[];
    for (final String image in images) {
      final File file = File(image);
      final String name =
          file.uri.pathSegments.last.replaceAll('image_picker_', '');

      final Stream<Uint8List> steram = file.openRead().transform(
        StreamTransformer<List<int>, Uint8List>.fromHandlers(
          handleData: (data, sink) {
            sink.add(Uint8List.fromList(data));
          },
        ),
      );

      await minio.putObject(sf$cosBucket, name, steram);

      result.add(name);
    }
    return result;
  }
}
