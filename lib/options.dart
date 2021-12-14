import 'package:args/args.dart';

class Options {
  const Options({
    required this.database,
    required this.port,
  });

  final String database;
  final int port;

  factory Options.fromArguments(List<String> arguments) {
    final parser = ArgParser()
      ..addOption('database', abbr: 'd', help: 'The path to the database.')
      ..addOption('port',
          abbr: 'p', help: 'The port to listen on.', defaultsTo: '8080');
    final results = parser.parse(arguments);
    return Options(
      database: results['database'],
      port: int.parse(results['port']),
    );
  }
}
