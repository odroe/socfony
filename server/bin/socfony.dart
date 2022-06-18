import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:socfony/server.dart';

/// Socfony gRPC server.
Future<void> main() async {
  /// Use any available host or container IP (usually `0.0.0.0`).
  final InternetAddress address = InternetAddress.anyIPv4;

  /// Create a gRPC server.
  final Server server = createServer();

  /// Start the server.
  await server.serve(
    address: address,
    port: 8080,
  );

  /// Wait for the server to shutdown.
  /// Use `ctrl-C` to stop the server.
  print('🎉Server listening on port ${server.port}');
}
