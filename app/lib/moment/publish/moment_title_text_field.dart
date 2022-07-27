import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Moment title editing controller Provider.
final AutoDisposeChangeNotifierProvider<TextEditingController>
    momentTitleControllerProvider =
    ChangeNotifierProvider.autoDispose<TextEditingController>(
  (ref) => TextEditingController(),
);

class MomentTitleTextField extends ConsumerWidget {
  const MomentTitleTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: ref.watch(momentTitleControllerProvider),
      decoration: const InputDecoration(
        hintText: '标题（可选）',
        prefixIcon: Icon(Icons.title),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
    );
  }
}
