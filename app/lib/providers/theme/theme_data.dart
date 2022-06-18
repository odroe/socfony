import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme_color.dart';

final themeDataProvider =
    Provider.family<ThemeData, Brightness>((Ref ref, Brightness brightness) {
  final Color color = ref.watch(themeColorProvider);

  return ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: color,
      brightness: brightness,
    ),
    useMaterial3: true,
  );
});
