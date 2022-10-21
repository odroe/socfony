import 'package:orm/configure.dart';
import 'package:socfony_server/configure.dart';

/// Prisma development environment configurator.
void configurator(PrismaDevelopment development) {
  final String connectionString = configure['DATABASE_URL'];
  final String? developmentConnectionString = configure['DATABASE_URL_DEV'];

  development.override(
      'DATABASE_URL', developmentConnectionString ?? connectionString);
}

/// Configure Prisma for development environment.
///
/// **NOTE**: Prisma development must is a executable.
///
/// The `main` function is a Dart executable file entrypoint.
void main() => PrismaDevelopment.server(configurator);
