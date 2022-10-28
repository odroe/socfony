import 'configure.dart';
import 'prisma_client.dart';

export 'prisma_client.dart';

final PrismaClient client = PrismaClient(
  datasources: Datasources(
    db: Datasource(
      url: configure['DATABASE_URL'],
    ),
  ),
);
