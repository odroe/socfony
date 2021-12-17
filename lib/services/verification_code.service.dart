// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/protos/google/protobuf/wrappers.pb.dart';
import 'package:server/protos/google/protobuf/empty.pb.dart';
import 'package:server/protos/verification_code.pbgrpc.dart';
import 'package:single/single.dart';

class VerificationCodeService extends VerificationCodeServiceBase {
  @override
  Future<Empty> send(ServiceCall call, StringValue request) async {
    final database = await single<DatabaseConnectionPool>().getConnection();
    final result = await database.query(
      r'SELECT * FROM verification_codes WHERE phone = @phone',
      substitutionValues: {'phone': request.value},
    );

    print(result);
    print(request.value);

    return Empty();
  }
}
