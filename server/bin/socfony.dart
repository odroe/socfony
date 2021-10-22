import 'dart:io';

import 'package:args/args.dart';
import 'package:get_it/get_it.dart';
import 'package:socfony/app.dart';

Future<void> main(List<String> args) async {
  // Create the parser
  final ArgParser parser = ArgParser()
    // Add help flag
    ..addFlag('help', abbr: 'h', help: 'Show usage information.')
    // Add the port option
    ..addOption('port', abbr: 'p', defaultsTo: '8080', help: 'Port to listen on.')
    // add the address option
    ..addOption('address', abbr: 'a', help: 'Address to listen on.', defaultsTo: InternetAddress.anyIPv4.address)
    // add the database option
    ..addOption('database', abbr: 'd', help: 'Database connection URL');

  // Parse the command-line arguments
  final ArgResults results = parser.parse(args);
  // Register lazy singleton.
  GetIt.I.registerLazySingleton(() => results);

  // If the user asked for help, print it out and exit.
  if (results['help']) {
    print(parser.usage);
    exit(0);
  }

  final server = createApp();
  server.serve(
    port: int.parse(results['port']),
    address: results['address'],
  );
  print('Server listening on port ${server.port}...');
}
