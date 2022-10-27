import 'package:grpc/grpc.dart';

import 'configure.dart';
import 'prisma.dart';

final Server server = Server([]);

void main() async {
  try {
    await server.serve(
      address: configure['LISTEN_ADDRESS'],
      port: int.tryParse(configure['LISTEN_PORT']),
    );

    print('🚀 Server listening on port ${server.port}...');
  } catch (e) {
    await server.shutdown();
    await prisma.$disconnect();

    rethrow;
  }
}
