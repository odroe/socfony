import 'dart:io' if (dart.library.html) 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Picked images provider.
final AutoDisposeStateProvider<List<String>> pickedImagesProvider =
    StateProvider.autoDispose<List<String>>(
  (ref) => const <String>[],
);

class MomentPickedImages extends ConsumerWidget {
  const MomentPickedImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch picked images count.
    final int count =
        ref.watch(pickedImagesProvider.select((value) => value.length));
    // If count is 0, return empty widget.
    if (count == 0) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount:
          ref.watch(pickedImagesProvider.select((value) => value.length)),
      itemBuilder: generateImageBuilder(ref.read),
    );
  }

  /// Generate image builder.
  IndexedWidgetBuilder generateImageBuilder(Reader reader) {
    return (BuildContext context, int index) {
      final String path = reader(pickedImagesProvider)[index];
      return GestureDetector(
        child: Hero(
          tag: path,
          child: Image.file(
            File(path),
            fit: BoxFit.cover,
          ),
        ),
        onTap: () => showPreview(context, index),
      );
    };
  }

  /// show preview.
  void showPreview(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _PickedImagePreview(initialIndex: index),
        fullscreenDialog: false,
      ),
    );
  }
}

class _PickedImagePreview extends ConsumerStatefulWidget {
  const _PickedImagePreview({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  /// Initial index.
  final int initialIndex;

  @override
  ConsumerState<_PickedImagePreview> createState() =>
      __PickedImagePreviewState();
}

class __PickedImagePreviewState extends ConsumerState<_PickedImagePreview> {
  late final PageController controller;

  late int currentIndex;

  @override
  void initState() {
    controller = PageController(
      initialPage: currentIndex = widget.initialIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch picked images count.
    final int count =
        ref.watch(pickedImagesProvider.select((value) => value.length));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${currentIndex + 1}/$count'),
        actions: [
          IconButton(
            onPressed: onDeleteImage,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: PageView.builder(
        controller: controller,
        itemCount: count,
        itemBuilder: itemBuilder,
        onPageChanged: onPageChanged,
      ),
    );
  }

  /// On page changed.
  void onPageChanged(int index) {
    setState(() => currentIndex = index);
  }

  /// Item builder.
  Widget itemBuilder(BuildContext context, int index) {
    final String path = ref.read(pickedImagesProvider)[index];
    return Hero(
      tag: path,
      child: Image.file(
        File(path),
        fit: BoxFit.contain,
      ),
    );
  }

  /// On delete image.
  void onDeleteImage() {
    // Remove image.
    ref.read(pickedImagesProvider.state).update(
          (state) => [
            for (int i = 0; i < state.length; i++)
              if (i != currentIndex) state[i]
          ],
        );

    // If picked images count is 0, pop.
    if (ref.read(pickedImagesProvider).isEmpty) {
      return Navigator.pop(context);
    }

    // Update page controller.
    controller.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
