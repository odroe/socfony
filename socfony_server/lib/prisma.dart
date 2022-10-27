import 'configure.dart';
import 'prisma_client.dart';

final PrismaClient prisma = PrismaClient(
  datasources: Datasources(
    db: Datasource(
      url: configure['DATABASE_URL'],
    ),
  ),
);
