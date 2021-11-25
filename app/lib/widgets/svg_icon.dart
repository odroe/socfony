import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

enum SvgIconType {
  string,
  asset,
  url,
  memory,
  file,
}

class SvgIcon extends StatelessWidget {
  const SvgIcon(
    this.provider, {
    Key? key,
    this.size,
    this.color,
    this.semanticLabel,
    required this.type,
  }) : super(key: key);

  final Object provider;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final SvgIconType type;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);

    final double? iconSize = size ?? iconTheme.size;

    final double iconOpacity = iconTheme.opacity ?? 1.0;
    Color iconColor = color ?? iconTheme.color!;
    if (iconOpacity != 1.0) {
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    }

    switch (type) {
      case SvgIconType.string:
        return SvgPicture.string(
          provider as String,
          color: iconColor,
          height: iconSize,
          width: iconSize,
          semanticsLabel: semanticLabel,
        );
      case SvgIconType.asset:
        return SvgPicture.asset(
          provider as String,
          color: iconColor,
          height: iconSize,
          width: iconSize,
          semanticsLabel: semanticLabel,
        );
      case SvgIconType.url:
        return SvgPicture.network(
          provider as String,
          color: iconColor,
          height: iconSize,
          width: iconSize,
          semanticsLabel: semanticLabel,
        );
      case SvgIconType.memory:
        return SvgPicture.memory(
          provider as Uint8List,
          color: iconColor,
          height: iconSize,
          width: iconSize,
          semanticsLabel: semanticLabel,
        );
      case SvgIconType.file:
        return SvgPicture.file(
          provider as File,
          color: iconColor,
          height: iconSize,
          width: iconSize,
          semanticsLabel: semanticLabel,
        );
    }
  }
}
