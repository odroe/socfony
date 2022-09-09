import 'package:rc/rc.dart';

class Configure {
  const Configure(this.rc);

  /// Current runtime configuration.
  final RuntimeConfiguration rc;

  /// Get database url.
  String? get databaseUrl => rc<String>('DATABASE_URL');

  /// Listen port.
  int get port => rc<int>('port') ?? 8080;
}

Configure get configure => Configure(
      RuntimeConfiguration.from('.env', includeEnvironment: true),
    );
