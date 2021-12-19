// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/protos/google/protobuf/empty.pb.dart';
import 'package:server/protos/google/protobuf/timestamp.pb.dart';
import 'package:server/protos/google/protobuf/wrappers.pb.dart';
import 'package:server/protos/user.pbgrpc.dart';
import 'package:single/single.dart';

import '../auth.dart';

class UserService extends UserServiceBase {
  @override
  Future<User> findUnique(
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

    return User()
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

  @override
  Future<UserListResponse> findMany(
      ServiceCall call, UserFindManyRequest request) async {
    if (request.where.isEmpty) {
      throw GrpcError.invalidArgument('Request must set where');
    }

    final List<String> ids = request.where
        .where(
            (element) => element.whichKind() == UserFindUniqueRequest_Kind.id)
        .map((element) => element.id)
        .toSet()
        .toList();
    final List<String> names = request.where
        .where(
            (element) => element.whichKind() == UserFindUniqueRequest_Kind.name)
        .map((element) => element.name)
        .toSet()
        .toList();
    final List<String> phones = request.where
        .where((element) =>
            element.whichKind() == UserFindUniqueRequest_Kind.phone)
        .map((element) => element.phone)
        .toSet()
        .toList();

    if ((ids.length + names.length + phones.length) > 100) {
      throw GrpcError.invalidArgument('Too many conditions, max 100');
    }

    final Map<String, String> substitutionValues = {};
    final wheres = <String>[];
    if (ids.isNotEmpty) {
      final keys = <String>[];
      for (int i = 0; i < ids.length; i++) {
        keys.add('@id$i');
        substitutionValues['id$i'] = ids[i];
      }
      wheres.add('id IN (${keys.join(', ')})');
    }
    if (names.isNotEmpty) {
      final keys = <String>[];
      for (int i = 0; i < names.length; i++) {
        keys.add('@name$i');
        substitutionValues['name$i'] = names[i];
      }
      wheres.add('name IN (${keys.join(', ')})');
    }
    if (phones.isNotEmpty) {
      final keys = <String>[];
      for (int i = 0; i < phones.length; i++) {
        keys.add('@phone$i');
        substitutionValues['phone$i'] = phones[i];
      }
      wheres.add('phone IN (${keys.join(', ')})');
    }

    final database = await single<DatabaseConnectionPool>().getConnection();
    final results = await database.mappedResultsQuery(
      'SELECT * FROM users WHERE ${wheres.join(' OR ')} LIMIT 100',
      substitutionValues: substitutionValues,
    );

    final users = results.map((element) {
      final user = element['users']!;
      final result = User();
      result.id = user['id'];
      result.name = user['name'];
      result.phone = _desensitization(user['phone']);
      result.createdAt = Timestamp.fromDateTime(user['created_at']);
      return result;
    });
    final response = UserListResponse(users: users);

    return response;
  }

  @override
  Future<UserListResponse> search(
      ServiceCall call, UserSearchRequest request) async {
    final String keyword = request.keyword;
    final int limit = request.hasLimit() ? request.limit : 15;
    final int offset = request.hasOffset() ? request.offset : 0;
    final database = await single<DatabaseConnectionPool>().getConnection();

    // Search `name` field in users/user_profiles table.
    final results = await database.mappedResultsQuery(
      r'SELECT users.* FROM users LEFT JOIN user_profiles ON users.id = user_profiles.user_id WHERE users.name ILIKE @keyword OR user_profiles.name ILIKE @keyword LIMIT @limit OFFSET @offset',
      substitutionValues: {
        'keyword': keyword,
        'limit': limit,
        'offset': offset,
      },
    );

    return UserListResponse(
      users: results.map((element) {
        final user = element['users']!;
        final result = User();
        result.id = user['id'];
        result.name = user['name'];
        result.phone = _desensitization(user['phone']);
        result.createdAt = Timestamp.fromDateTime(user['created_at']);
        return result;
      }),
    );
  }

  @override
  Future<Empty> updateName(ServiceCall call, StringValue request) async {
    final accessToken =
        await single<Auth>().getAccessToken(call.clientMetadata);
    single<Auth>().validate(accessToken: accessToken);

    // Find user by name.
    final database = await single<DatabaseConnectionPool>().getConnection();
    final results = await database.mappedResultsQuery(
      'SELECT * FROM users WHERE name = @name AND id != @id',
      substitutionValues: {
        'name': request.value,
        'id': accessToken!.userId,
      },
    );

    // If results not empty, name is already used.
    if (results.isNotEmpty) {
      throw GrpcError.invalidArgument(
          'Account name ${request.value} is already used');
    }

    // Update current user name.
    await database.execute(
      'UPDATE users SET name = @name WHERE id = @id',
      substitutionValues: {
        'name': request.value,
        'id': accessToken.userId,
      },
    );

    return Empty();
  }
}
