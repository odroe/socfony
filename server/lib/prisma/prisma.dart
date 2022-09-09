import '../configure.dart';
import 'prisma_client.dart';

export 'prisma_client.dart';

PrismaClient get prisma {
  print(configure.databaseUrl);
  final Datasources datasources = Datasources(
    db: configure.databaseUrl == null
        ? null
        : Datasource(url: configure.databaseUrl),
  );

  return PrismaClient(
    datasources: datasources,
  );
}
