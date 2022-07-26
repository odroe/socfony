import 'package:flutter/material.dart';

import 'account_id_card.dart';

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
                tiles: [
                  ListTile(
                    title: const Text('性别'),
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('男'),
                    ),
                  ),
                  // 生日
                  ListTile(
                    title: const Text('生日'),
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('2020-01-01'),
                    ),
                  ),
                  // 简介
                  ListTile(
                    title: Row(
                      children: [
                        const Expanded(child: Text('简介')),
                        TextButton(
                          onPressed: () {},
                          child: const Text('编辑'),
                        ),
                      ],
                    ),
                    subtitle: const Text(
                        'Socfony has a huge community of enthusiasts and developers who love open source programs. You can scan the QR code below to join the WeChat group to communicate with them.'),
                  ),
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
    // return SizedBox.square(
    //   dimension: 64,
    //   child: Stack(
    //     alignment: Alignment.center,
    //     children: [
    //       Positioned.fill(child: CircleAvatar()),
    //     ],
    //   ),
    // );
    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     CircleAvatar(),
    //     Positioned(
    //       child: Icon(Icons.edit),
    //       bottom: 0,
    //       right: 0,
    //     ),
    //   ],
    // );
  }
}
