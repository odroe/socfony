import 'dart:io';

import 'package:socfony/configure.dart';
import 'package:socfony/prisma/prisma.dart';
import 'package:socfony/server.dart';

/// Socfony gRPC server.
Future<void> main() async {
  /// Use any available host or container IP (usually `0.0.0.0`).
  final InternetAddress address = InternetAddress.anyIPv4;

  try {
    /// Start the server.
    await server.serve(address: address, port: configure.port);

    print('🎉Server listening on port ${server.port}');
  } catch (e) {
    await prisma.$disconnect();
    await server.shutdown();

    rethrow;
  }
}
