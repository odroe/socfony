// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/database/connection_pool.dart';
import 'package:single/single.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../auth.dart';
import '../get_federation_token.dart';
import '../sms.dart';

class TencentCloudService extends TencentCloudServiceBase {
  @override
  Future<TencentCloudCredentials> createCosFederationCredentials(
      ServiceCall call, Empty request) async {
    final accessToken =
        await single<Auth>().getAccessToken(call.clientMetadata);

    return await single<GetFederationToken>().token(accessToken?.userId);
  }

  @override
  Future<Empty> sendSmsOTP(ServiceCall call, StringValue request) async {
    final database = await single<DatabaseConnectionPool>().getConnection();
    final message = SMS(request.value)..send();
    final expiredAt = DateTime.now().add(Duration(minutes: message.minute));

    await database.execute(
      r'INSERT INTO verification_codes (phone, code, expired_at) VALUES (@phone, @code, @expired_at)',
      substitutionValues: {
        'phone': message.phone,
        'code': message.code,
        'expired_at': expiredAt,
      },
    );

    _deleteAllExpired();

    return Empty();
  }

  void _deleteAllExpired() async {
    final database = await single<DatabaseConnectionPool>().getConnection();
    await database.execute(
      r'DELETE FROM verification_codes WHERE expired_at < @now',
      substitutionValues: {'now': DateTime.now()},
    );
  }
}
