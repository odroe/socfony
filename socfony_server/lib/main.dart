import 'dart:io';

import 'package:grpc/grpc.dart';

import 'configure.dart';
import 'prisma.dart';
import 'services/user_service.dart';
import 'utils/get_free_port.dart';

final Server server = Server([
  UserService(),
]);

void main() async {
  try {
    await server.serve(
      address: configure['LISTEN_ADDRESS'] ?? InternetAddress.loopbackIPv4,
      port: int.tryParse(configure['LISTEN_PORT'].toString()) ??
          await getFreePort(),
    );

    print('🚀 Server listening on port ${server.port}...');
  } catch (e) {
    await server.shutdown();
    await client.$disconnect();

    rethrow;
  }
}
