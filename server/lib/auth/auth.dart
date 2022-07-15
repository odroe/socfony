import '../database/connection.dart';

class Auth {
  final PooledDatabaseConnection connection;

  const Auth(this.connection);
}
