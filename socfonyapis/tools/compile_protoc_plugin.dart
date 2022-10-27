import 'dart:io';

import 'package:path/path.dart';

String main() {
  final String entry =
      relative(joinAll([dirname(Platform.script.path), 'protoc_plugin.dart']));

  final String output = joinAll([
    dirname(Platform.script.path),
    '..',
    '.dart_tool',
    'protobuf',
    'protoc-gen-dart',
  ]);
  final File outputFile = File(relative(output));
  if (outputFile.existsSync()) {
    return outputFile.path;
  }

  final ProcessResult result = Process.runSync(
      Platform.resolvedExecutable, ['compile', 'exe', entry, '-o', output]);
  if (result.exitCode != 0) {
    stderr.write(result.stderr);
  }

  stdout.write(result.stdout);
  exitCode = result.exitCode;

  return outputFile.path;
}
