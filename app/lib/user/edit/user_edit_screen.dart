import 'package:flutter/material.dart';

import 'account_id_card.dart';
import 'user_bio_list_tile.dart';
import 'user_birthday_list_tile.dart';
import 'user_gender_list_tile.dart';

class UserEditScreen extends StatelessWidget {
  const UserEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('账户信息'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const _UserAvatarEditCard(),
          const SizedBox(height: 24),
          const AccountIdCard(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
            child: Text('资料', style: Theme.of(context).textTheme.bodySmall),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: const <Widget>[
                  UserGenderListTile(),
                  UserBirthdayListTile(),
                  UserBioListTile(),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserAvatarEditCard extends StatelessWidget {
  const _UserAvatarEditCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 92,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.background,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
