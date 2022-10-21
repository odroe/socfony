/// Socfony server configuration generator.
///
/// This script generates a configuration file for the Socfony server.
library socfony_server.tools;

import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

/// The configuration file.
final File inputFile = File('configure.yaml');

/// Output configuration file.
final File outputFile = File('lib/configure.dart');

/// Executable entry point.
void main() {
  // Read the configuration file.
  final String input = inputFile.readAsStringSync();

  // Parse the configuration
  final Map<String, dynamic> config = (loadYaml(input) as Map).cast();

  final String output = '''
import 'dart:convert';
final Map<String, dynamic> configure = utf8.decode(${utf8.encode(json.encode(config))}) as Map<String, dynamic>;
''';

  // Write the configuration file.
  outputFile.writeAsStringSync(output);
}
