import 'package:grpc/grpc.dart';
import 'package:server2/codec_registry.dart';

import 'interceptors/interceptors.dart';
import 'services/services.dart';

Future<void> run() async {
  final server = Server(
    services,
    interceptors,
    codecRegistry,
  );

  await server.serve(
    address: '0.0.0.0',
    port: 3000,
  );

  print('Server listening on port ${server.port}...');
}
