import 'dart:io';

void main(Iterable<String> files) {
  if (Platform.isWindows) return;

  for (final String path in files) {
    final File file = File(path);
    if (!file.existsSync()) {
      print('File not found: $path');
      continue;
    }

    final ProcessResult result = Process.runSync('chmod', ['+x', path]);
    if (result.exitCode != 0) {
      print('Failed to chmod +x $path');
      print(result.stdout);
      print(result.stderr);
    }
  }
}
