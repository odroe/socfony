import 'package:rc/rc.dart';
import 'package:orm/configure.dart' show environment;

class Configure {
  Configure() {
    // Create a runtime configuration.
    rc = RuntimeConfiguration.from('.env', includeEnvironment: true);

    // Set Prisma runtime configuration.
    environment.custom(rc);
  }

  /// Current runtime configuration.
  late final RuntimeConfiguration rc;

  /// Get database url.
  String? get databaseUrl => rc<String>('DATABASE_URL');

  /// Listen port.
  int get port => rc<int>('port') ?? 8080;
}

final Configure configure = Configure();
