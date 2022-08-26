import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../configure.dart';
import '../minio.dart';
import 'user_providers.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({super.key, this.id, this.size});

  /// Avatar size.
  final double? size;

  /// User ID.
  final String? id;

  /// Circle avatar radius.
  double? get radius => size != null ? size! / 2 : null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Color scheme.
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // If id is null, return default avatar.
    if (id == null) return _DefaultUserAvatar(radius: radius);

    // User avatar provider.
    final provider = createUserProvider(id!).select((value) => value?.avatar);

    // Watch user avatar.
    final avatar = ref.watch(provider);

    // If avatar is null, return default avatar.
    if (avatar == null) return _DefaultUserAvatar(radius: radius);

    return FutureBuilder<ImageProvider?>(
      future: createImageProvider(avatar),
      builder: (context, snapshot) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: snapshot.data,
          backgroundColor: colorScheme.primaryContainer,
        );
      },
    );
  }

  /// Create image provider from avatar.
  Future<ImageProvider?> createImageProvider(String avatar) async {
    final String url = await minio.presignedUrl('get', sf$cosBucket, avatar);

    return CachedNetworkImageProvider(url);
  }
}

class _DefaultUserAvatar extends StatelessWidget {
  const _DefaultUserAvatar({this.radius});

  final double? radius;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primaryContainer,
      child: Icon(
        Icons.person,
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }
}
