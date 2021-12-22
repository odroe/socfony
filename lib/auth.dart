//opyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/protos/access_token.pb.dart';
import 'package:server/protos/google/protobuf/timestamp.pb.dart';
import 'package:single/single.dart';

class Auth {
  const Auth._();
  static Auth Function() get fromSingle => () => Auth._();

  String get key => r'Authorization';

  String? getToken([Map<String, String>? metadata]) {
    for (MapEntry<String, String> entry in metadata?.entries ?? {}) {
      if (entry.key.toLowerCase() == key.toLowerCase()) {
        return entry.value;
      }
    }
  }

  Future<AccessToken?> getAccessToken([Map<String, String>? metadata]) async {
    final String? token = getToken(metadata);
    if (token == null) {
      return null;
    }

    final database = await single<DatabaseConnectionPool>().getConnection();
    final results = await database.mappedResultsQuery(
      r'SELECT * FROM access_tokens WHERE token = @token LIMIT 1',
      substitutionValues: {'token': token},
    );

    if (results.isEmpty) {
      return null;
    }

    final result = results.single.entries
        .where((element) => element.key == 'access_tokens');
    if (result.isEmpty) {
      return null;
    }

    final value = result.single.value;
    final response = AccessToken();
    response.token = value['token'];
    response.userId = value['user_id'];
    response.expiredAt = Timestamp.fromDateTime(value['expired_at']);
    response.refreshExpiredAt =
        Timestamp.fromDateTime(value['refresh_expired_at']);

    return response;
  }

  Future<Map<String, dynamic>?> getUser([Map<String, String>? metadata]) async {
    final accessToken = await getAccessToken(metadata);
    if (accessToken == null) {
      return null;
    }

    final database = await single<DatabaseConnectionPool>().getConnection();
    final results = await database.mappedResultsQuery(
      r'SELECT * FROM users WHERE id = @id LIMIT 1',
      substitutionValues: {'id': accessToken.userId},
    );

    if (results.isEmpty) {
      return null;
    }

    final result =
        results.single.entries.where((element) => element.key == 'users');
    return result.isEmpty ? null : result.single.value;
  }

  void validate({
    AccessToken? accessToken,
    bool isRefresh = false,
  }) {
    if (accessToken == null) {
      throw GrpcError.unauthenticated('Access token is required');
    }

    final DateTime expired = isRefresh
        ? accessToken.refreshExpiredAt.toDateTime()
        : accessToken.expiredAt.toDateTime();

    if (expired.isBefore(DateTime.now())) {
      throw GrpcError.unauthenticated('Access token has expired');
    }
  }
}
