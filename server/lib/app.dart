import 'package:get_it/get_it.dart';
import 'package:grpc/grpc.dart' show Server;
import 'package:postgres/postgres.dart';

import 'codec_registry.dart';
import 'interceptors/interceptors.dart';
import 'services/services.dart';

Server createApp() {
  // Create a server.
  final Server server = Server(
    services,
    interceptors,
    codecRegistry,
  );
  GetIt.I.registerSingleton<Server>(server);

  // Create database connection.
  final connection = PostgreSQLConnection(host, port, databaseName)

  return server;
}
