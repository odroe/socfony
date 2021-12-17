// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/protos/google/protobuf/timestamp.pb.dart';
import 'package:server/protos/user.pbgrpc.dart';
import 'package:single/single.dart';

class UserService extends UserServiceBase {
  @override
  Future<UserResponse> findUnique(
      ServiceCall call, UserFindUniqueRequest request) async {
    final UserFindUniqueRequest_Kind kind = request.whichKind();
    if (kind == UserFindUniqueRequest_Kind.notSet) {
      throw GrpcError.invalidArgument('Request must set one of the fields');
    }

    final String field = kind.name;
    final String value = request.getField(request.getTagNumber(field)!);
    final database = await single<DatabaseConnectionPool>().getConnection();

    final results = await database.mappedResultsQuery(
      'SELECT * FROM users WHERE $field = @value',
      substitutionValues: {'value': value},
    );

    if (results.isEmpty) {
      throw GrpcError.notFound('User not found');
    }

    final result = results.single['users']!;

    return UserResponse()
      ..id = result['id']
      ..name = result['name']
      ..phone = _desensitization(result['phone'])
      ..createdAt = Timestamp.fromDateTime(result['created_at']);
  }

  String _desensitization(String value) {
    final length = value.length;
    final half = length ~/ 2;
    return '${value.substring(0, half)}${'*' * (length - half)}';
  }
}
