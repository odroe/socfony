import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

import 'install_protobuf.dart' as install_protobuf;
import 'compile_protoc_plugin.dart' as compile_protoc_plugin;

final String rootDir = dirname(dirname(Platform.script.path));
final String protosDir = join(rootDir, 'protos');
final String libDir = join(rootDir, 'lib');
final String srcDir = join(libDir, 'src');

/// All the proto files to compile.
Iterable<String> get protoFiles => Directory(protosDir)
    .listSync(recursive: true)
    .whereType<File>()
    .map((File entity) => entity.path);

/// All imported google/protobuf/*.proto files.
Iterable<String> get importedGoogleProtobufFiles sync* {
  final Set<String> imported = <String>{};
  final Directory directory = Directory(protosDir);
  if (!directory.existsSync()) return;

  for (final String file in protoFiles) {
    final String contents = File(file).readAsStringSync();
    final Iterable<RegExpMatch> matches =
        RegExp(r'import\s+"google/protobuf/(\w+).proto"').allMatches(contents);
    for (final RegExpMatch match in matches) {
      final String? name = match.group(1);
      if (name != null && !imported.contains(name)) {
        imported.add(name);
        yield "google/protobuf/$name.proto";
      }
    }
  }
}

void main() async {
  final String protocExecutable = await install_protobuf.main();
  final String protocGenDartExecutable = compile_protoc_plugin.main();
  final Directory src = Directory(srcDir);
  if (src.existsSync()) {
    src.deleteSync(recursive: true);
  }
  src.create(recursive: true);

  final Process process = await Process.start(
    protocExecutable,
    [
      '--dart_out=grpc:$srcDir',
      '--plugin=protoc-gen-dart=$protocGenDartExecutable',
      '--proto_path=$protosDir',
      ...protoFiles.map((e) => relative(e, from: protosDir)),
      ...importedGoogleProtobufFiles,
    ],
  );

  process.stdout.transform(utf8.decoder).listen(print);
  process.stderr.transform(utf8.decoder).listen(print);

  exitCode = await process.exitCode;

  final StringBuffer buffer = StringBuffer('''
// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library socfonyapis;
''');
  for (final File file in src.listSync(recursive: true).whereType<File>()) {
    // '*.pbjson.dart'
    if (file.path.endsWith('.pbjson.dart')) {
      file.deleteSync();
      continue;
    }

    // 'google/protobuf/*.pbenum.dart'
    if (file.path.endsWith('.pbenum.dart') &&
        file.path.contains('google/protobuf/')) {
      file.deleteSync();
      continue;
    }

    // Export all other dart files.
    if (file.path.endsWith('.dart')) {
      final String path = relative(file.path, from: srcDir);
      buffer.writeln("export 'src/$path';");
    }
  }

  final File libFile = File(join(libDir, 'socfonyapis.dart'));
  libFile.writeAsStringSync(buffer.toString());

  /// Format the generated code.
  await Process.run(
    Platform.resolvedExecutable,
    [
      'format',
      '-o',
      'write',
      '--fix',
      relative(libDir),
    ],
  );
}
