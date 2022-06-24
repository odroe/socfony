import 'package:pool/pool.dart';
import 'package:postgres/postgres.dart';

import '../configures.dart';
import 'options.dart';
import 'pool.dart';

class PooledDatabaseConnection extends PostgreSQLConnection {
  final PoolResource _poolResource;

  PooledDatabaseConnection(
      DatabaseConnectionOptions options, this._poolResource)
      : super(
          options.host,
          options.port,
          options.databaseName,
          timeoutInSeconds: options.connectionTimeout,
          queryTimeoutInSeconds: options.queryTimeout,
          username: options.username,
          password: options.password,
          timeZone: options.timezone,
          useSSL: options.useSSL,
          isUnixSocket: options.isUnixSocket,
          allowClearTextPassword: options.allowClearTextPassword,
        );

  static Future<PooledDatabaseConnection> connect() async {
    final PoolResource poolResource = await kDatabasePool.request();
    final PooledDatabaseConnection connection =
        PooledDatabaseConnection(kDatabaseConnectionOptions, poolResource);

    try {
      await connection.open();
    } catch (e) {
      poolResource.release();

      rethrow;
    }

    return connection;
  }

  @override
  Future<PooledDatabaseConnection> close() async {
    await super.close();
    _poolResource.release();

    return this;
  }
}
