import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocfonyIcon extends Icon {
  const SocfonyIcon({
    super.key,
    super.color,
    super.size,
    super.semanticLabel,
  }) : super(null);

  @override
  Widget build(BuildContext context) {
    // Read icon theme data.
    final IconThemeData theme = IconTheme.of(context);

    Icon(icon);

    return SvgPicture.asset(
      'assets/socfony.svg',
      width: size ?? theme.size,
      color: color ?? theme.color,
      semanticsLabel: semanticLabel,
    );
  }
}
