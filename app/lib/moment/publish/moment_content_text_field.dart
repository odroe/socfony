import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Moment context editing controller Provider.
final AutoDisposeChangeNotifierProvider<TextEditingController>
    momentContentControllerProvider =
    ChangeNotifierProvider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

class MomentContextTextField extends ConsumerWidget {
  const MomentContextTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      autofocus: true,
      controller: ref.watch(momentContentControllerProvider),
      decoration: const InputDecoration(
        hintText: '丰富的内容更能吸引人～',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      maxLength: 300,
    );
  }
}
