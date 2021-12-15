import 'dart:io';

class Options {
  const Options._({
    required this.database,
    required this.port,
  });

  final String database;
  final int port;

  factory Options.fromEnvironment() {
    final String? database = Platform.environment['SOCFONY_DATABASE'];
    final int port = Platform.environment['SOCFONY_PORT'] != null
        ? int.tryParse(Platform.environment['SOCFONY_PORT']!) ?? 8080
        : 8080;

    if (database == null || database.isEmpty) {
      throw Exception('SOCFONY_DATABASE environment variable is required');
    }

    return Options._(
      database: database,
      port: port,
    );
  }
}
