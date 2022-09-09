import 'package:grpc/grpc.dart';

import '../prisma/prisma.dart';

Future<GrpcError?> prismaConnector(
    ServiceCall call, ServiceMethod method) async {
  await prisma.$connect();

  return null;
}
