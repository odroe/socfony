import '../connection.dart';

class BaseRepository {
  const BaseRepository();

  /// Get database connection.
  Future<PooledDatabaseConnection> getConnection([
    PooledDatabaseConnection? connection,
  ]) {
    if (connection is PooledDatabaseConnection) {
      return Future.value(connection);
    }

    return PooledDatabaseConnection.connect();
  }
}
