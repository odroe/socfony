// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/protos/google/protobuf/wrappers.pb.dart';
import 'package:server/protos/google/protobuf/empty.pb.dart';
import 'package:server/protos/verification_code.pbgrpc.dart';
import 'package:server/sms.dart';
import 'package:single/single.dart';

class VerificationCodeService extends VerificationCodeServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) async {
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

    return Empty();
  }
}
