import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('外观与色彩'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 24),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('外观', style: Theme.of(context).textTheme.bodySmall),
          ),
          const _ThemeModeCard(),
        ],
      ),
    );
  }
}

class _ThemeModeCard extends StatelessWidget {
  const _ThemeModeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                _ThemeModeRadio(
                  brightness: Brightness.light,
                  label: '浅色',
                  icon: Icons.light_mode_outlined,
                  selectedIcon: Icons.light_mode,
                ),
                _ThemeModeRadio(
                  brightness: Brightness.dark,
                  label: '深色',
                  icon: Icons.dark_mode_outlined,
                  selectedIcon: Icons.dark_mode,
                ),
              ],
            ),
            const Divider(
              indent: 12,
              endIndent: 12,
            ),
            const _AutoThemeModeSwitchListTile(),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeRadio extends ConsumerWidget {
  const _ThemeModeRadio({
    Key? key,
    required this.brightness,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  }) : super(key: key);

  final IconData selectedIcon;
  final IconData icon;
  final String label;
  final Brightness brightness;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Current theme data.
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Icon(theme.brightness == brightness ? selectedIcon : icon),
        Text(label),
        Radio<Brightness>(
          value: brightness,
          groupValue: theme.brightness,
          onChanged: (Brightness? value) => saveThemeMode(ref.read, themeMode),
          activeColor: theme.colorScheme.primary,
        ),
      ],
    );
  }

  /// Get current brightness tranform to theme mode.
  ThemeMode get themeMode {
    switch (brightness) {
      case Brightness.light:
        return ThemeMode.light;
      case Brightness.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

class _AutoThemeModeSwitchListTile extends ConsumerWidget {
  const _AutoThemeModeSwitchListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch theme mode controller.
    final ThemeModeController themeModeController =
        ref.watch(themeModeControllerProvider);

    return ListTile(
      title: const Text('自动'),
      subtitle: const Text('开启后将跟随系统自动改变外观'),
      trailing: Switch(
        value: themeModeController.value == ThemeMode.system,
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: (bool? value) => _update(context, ref.read, value),
      ),
    );
  }

  /// Update theme mode controller.
  void _update(BuildContext context, Reader reader, bool? value) async {
    // Build theme mode value.
    final ThemeMode mode = _buildThemeMode(context, value);

    // Update theme mode controller.
    await saveThemeMode(reader, mode);
  }

  /// Build theme mode value.
  ThemeMode _buildThemeMode(BuildContext context, bool? value) {
    // If value is null or true, use system theme mode.
    if (value == null || value == true) {
      return ThemeMode.system;
    }

    switch (MediaQuery.of(context).platformBrightness) {
      case Brightness.light:
        return ThemeMode.light;
      case Brightness.dark:
        return ThemeMode.dark;
    }
  }
}
