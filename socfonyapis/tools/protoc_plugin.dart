import 'dart:io';

import 'package:protoc_plugin/protoc.dart';

/// Ref https://github.com/google/protobuf.dart/blob/master/protoc_plugin/bin/protoc_plugin.dart
void main(List<String> args) {
  CodeGenerator(stdin, stdout).generate();
}
