import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../../auth/auth_provider.dart';
import '../../socfony_service.dart';
import '../user_providers.dart';

/// birthday provider.
final _birthdayProvider = Provider.autoDispose<DateTime?>((Ref ref) {
  /// Selecte and watch user 8 length birthday.
  final int? birthday = ref.watch(
    authenticatedUserProvider.select((value) => value?.birthday),
  );

  // If birthday is null or length is not 8, return null.
  if (birthday == null || birthday.toString().length != 8) {
    return null;
  }

  // Select year from birthday.
  final int year = birthday ~/ 10000;

  // Select month from birthday.
  final int month = (birthday ~/ 100) % 100;

  // Select day from birthday.
  final int day = birthday % 100;

  // Return birthday.
  return DateTime(year, month, day);
});

/// User birthday list tile.
class UserBirthdayListTile extends StatelessWidget {
  const UserBirthdayListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('生日'),
      trailing: _BirthdayButton(),
    );
  }
}

class _BirthdayText extends ConsumerWidget {
  const _BirthdayText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime? birthday = ref.watch(_birthdayProvider);

    return Text(birthday == null
        ? '设置生日'
        : MaterialLocalizations.of(context).formatShortDate(birthday));
  }
}

class _BirthdayButton extends ConsumerWidget {
  const _BirthdayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => _showDatePicker(context, ref.read),
      child: const _BirthdayText(),
    );
  }

  /// Show date picker.
  void _showDatePicker(BuildContext context, Reader reader) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: reader(_birthdayProvider) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    // If selected is not null, set birthday.
    if (selected != null) {}
    final User user = await socfonyService
        .updateUser(UpdateUserRequest()..birthday = _date2int(selected!));
    user.save(reader);
  }

  // Date to 8 length int.
  int _date2int(DateTime date) {
    return date.year * 10000 + date.month * 100 + date.day;
  }
}
