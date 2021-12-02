import 'package:app/src/store/store_context.dart';
import 'package:app/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('主题'),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 8),
          _ThemeMode(),
          _ThemeColor(),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const ThemeScreen(),
      ),
    );
  }
}

class _ThemeMode extends StatelessWidget {
  const _ThemeMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = context.store.watch<ThemeMode>() ?? ThemeMode.system;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      child: ListTile(
        leading: const Icon(Icons.dark_mode),
        title: const Text('外观'),
        trailing: DropdownButton<ThemeMode>(
          value: mode,
          items: const [
            DropdownMenuItem<ThemeMode>(
              value: ThemeMode.system,
              child: Text('跟随系统'),
            ),
            DropdownMenuItem<ThemeMode>(
              value: ThemeMode.light,
              child: Text('浅色'),
            ),
            DropdownMenuItem<ThemeMode>(
              value: ThemeMode.dark,
              child: Text('深色'),
            ),
          ],
          onChanged: (ThemeMode? mode) async {
            final ThemeMode value = mode ?? ThemeMode.system;
            context.store.write<ThemeMode>(value);

            final prefs = await SharedPreferences.getInstance();
            prefs.setInt('ThemeMode', themeMode2int(value));
          },
        ),
      ),
    );
  }

  themeMode2int(ThemeMode value) {
    switch (value) {
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
      default:
        return 0;
    }
  }
}

class _ThemeColor extends StatelessWidget {
  const _ThemeColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color =
        context.store.watch<Color>() ?? AppTheme.defaultPrimaryColor;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      child: ListTile(
        leading: const Icon(Icons.color_lens),
        title: const Text('颜色'),
        trailing: DropdownButton<Color>(
          value: color,
          items: [
            const DropdownMenuItem<Color>(
              alignment: Alignment.center,
              value: AppTheme.defaultPrimaryColor,
              child: Icon(
                Icons.circle,
                color: AppTheme.defaultPrimaryColor,
              ),
            ),
            ...Colors.accents.map((Color color) {
              return DropdownMenuItem<Color>(
                alignment: Alignment.center,
                value: Color(color.value),
                child: Icon(
                  Icons.circle,
                  color: color,
                ),
              );
            }).toList(),
          ],
          onChanged: (Color? color) async {
            final Color value = color ?? AppTheme.defaultPrimaryColor;
            context.store.write<Color>(value);

            final prefs = await SharedPreferences.getInstance();
            prefs.setInt('ThemeColor', value.value);
          },
        ),
      ),
    );
  }
}
