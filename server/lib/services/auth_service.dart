import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../database/connection.dart';

class AuthService extends AuthServiceBase {
  @override
  Future<AccessToken> create(
      ServiceCall call, CreateAccessTokenRequest request) async {
    final PooledDatabaseConnection connection =
        await PooledDatabaseConnection.connect();

    final results = await connection.query('SELECT * FROM users');

    for (final row in results) {
      print(row.toColumnMap());
    }

    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Empty> delete(ServiceCall call, Empty request) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<AccessToken> refresh(ServiceCall call, Empty request) {
    // TODO: implement refresh
    throw UnimplementedError();
  }
}
