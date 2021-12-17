// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:server/auth.dart';
import 'package:server/configuration.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/helpers/string.helper.dart';
import 'package:server/protos/access_token.pbgrpc.dart';
import 'package:server/protos/google/protobuf/empty.pb.dart';
import 'package:server/protos/google/protobuf/timestamp.pb.dart';
import 'package:single/single.dart';

class AccessTokenService extends AccessTokenServiceBase {
  @override
  Future<AccessTokenResponse> create(
      ServiceCall call, AccessTokenCreateRequest request) async {
    final done = await _validateOtp(request.phone, request.otp);
    final options = single<Configuration>().accessToken;
    final user = await _resolveUserFromPhone(request.phone);

    final now = DateTime.now();
    final response = AccessTokenResponse();
    response.userId = user['id'];
    response.token = StringHelper.string(128);
    response.expiredAt =
        Timestamp.fromDateTime(now.add(Duration(days: options.expiredInDays)));
    response.refreshExpiredAt = Timestamp.fromDateTime(
        now.add(Duration(days: options.refreshExpiredInDays)));
    response.createdAt = Timestamp.fromDateTime(now);

    final database = await single<DatabaseConnectionPool>().getConnection();
    database.execute(
      r'INSERT INTO access_tokens (user_id, token, expired_at, refresh_expired_at) VALUES (@userId, @token, @expiredAt, @refreshExpiredAt)',
      substitutionValues: {
        'userId': response.userId,
        'token': response.token,
        'expiredAt': response.expiredAt.toDateTime(),
        'refreshExpiredAt': response.refreshExpiredAt.toDateTime(),
      },
    );
    done.call();
    _deleteAllExpiredTokens();

    return response;
  }

  @override
  Future<AccessTokenResponse> refresh(ServiceCall call, Empty request) async {
    final accessToken =
        await single<Auth>().getAccessToken(call.clientMetadata);
    single<Auth>().validate(
      accessToken: accessToken,
      isRefresh: true,
    );

    final database = await single<DatabaseConnectionPool>().getConnection();

    // Set current access token refresh expired at to now + 5 minutes
    // and set expired at to now.
    database.execute(
      r'UPDATE access_tokens SET refresh_expired_at = NOW(), expired_at = @expiredAt, has_refreshed = true WHERE token = @token',
      substitutionValues: {
        'token': accessToken!.token,
        'expiredAt': DateTime.now().add(Duration(minutes: 5)),
      },
    );

    accessToken.token = StringHelper.string(128);
    accessToken.expiredAt = Timestamp.fromDateTime(DateTime.now().add(
        Duration(days: single<Configuration>().accessToken.expiredInDays)));
    accessToken.refreshExpiredAt = Timestamp.fromDateTime(DateTime.now().add(
        Duration(
            days: single<Configuration>().accessToken.refreshExpiredInDays)));

    /// Create new access token
    database.execute(
      r'INSERT INTO access_tokens (user_id, token, expired_at, refresh_expired_at) VALUES (@userId, @token, @expiredAt, @refreshExpiredAt)',
      substitutionValues: {
        'userId': accessToken.userId,
        'token': accessToken.token,
        'expiredAt': accessToken.expiredAt.toDateTime(),
        'refreshExpiredAt': accessToken.refreshExpiredAt.toDateTime(),
      },
    );

    _deleteAllExpiredTokens();

    return accessToken;
  }

  @override
  Future<Empty> revoke(ServiceCall call, Empty request) async {
    final accessToken =
        await single<Auth>().getAccessToken(call.clientMetadata);
    single<Auth>().validate(
      accessToken: accessToken,
      isRefresh: true,
    );

    final database = await single<DatabaseConnectionPool>().getConnection();

    // Delete access token
    database.execute(
      r'DELETE FROM access_tokens WHERE token = @token',
      substitutionValues: {
        'token': accessToken!.token,
      },
    );

    _deleteAllExpiredTokens();

    return Empty();
  }

  Future<Map<String, dynamic>> _resolveUserFromPhone(String phone) async {
    final Map<String, dynamic>? user = await _findUserFromPhone(phone);

    if (user != null) {
      return user;
    }

    final Map<String, dynamic> values = {
      'id': StringHelper.string(64),
      'phone': phone,
      'name': StringHelper.string(64),
    };
    final database = await single<DatabaseConnectionPool>().getConnection();
    await database.execute(
      r'INSERT INTO users (id, name, phone) VALUES (@id, @name, @phone)',
      substitutionValues: values,
    );

    return values;
  }

  Future<Map<String, dynamic>?> _findUserFromPhone(String phone) async {
    final database = await single<DatabaseConnectionPool>().getConnection();
    final results = await database.mappedResultsQuery(
      r'SELECT id, phone FROM users WHERE phone = @phone',
      substitutionValues: {'phone': phone},
    );

    if (results.isEmpty) {
      return null;
    }

    final row = results.first;
    if (row['users'] != null) {
      return row['users'];
    }
  }

  Future<void Function()> _validateOtp(String phone, String otp) async {
    final database = await single<DatabaseConnectionPool>().getConnection();
    final results = await database.mappedResultsQuery(
      r'SELECT expired_at FROM verification_codes WHERE phone = @phone AND code = @otp AND expired_at > NOW()',
      substitutionValues: {'phone': phone, 'otp': otp},
    );
    database.execute(
      r'DELETE FROM verification_codes WHERE expired_at < NOW()',
    );

    if (results.isEmpty) {
      throw GrpcError.invalidArgument('Invalid otp');
    }

    return () async {
      await database.execute(
        r'DELETE FROM verification_codes WHERE phone = @phone AND code = @otp',
        substitutionValues: {'phone': phone, 'otp': otp},
      );
    };
  }

  void _deleteAllExpiredTokens() async {
    final database = await single<DatabaseConnectionPool>().getConnection();
    await database.execute(
      r'DELETE FROM access_tokens WHERE expired_at < NOW() AND has_refreshed IS true',
    );
  }
}
