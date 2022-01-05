// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/protobuf/google/protobuf/empty.pb.dart';
import 'package:server/protobuf/google/protobuf/wrappers.pb.dart';
import 'package:server/protobuf/socfony.pbgrpc.dart';
import 'package:single/single.dart';

import '../auth.dart';

class UserProfileService extends UserProfileServiceBase {
  @override
  Future<UserProfile> find(ServiceCall call, StringValue request) async {
    final database = await single<DatabaseConnectionPool>().getConnection();
    final results = await database.mappedResultsQuery(
      r'SELECT * FROM user_profiles WHERE user_id = @userId',
      substitutionValues: {'userId': request.value},
    );

    if (results.isEmpty) {
      return UserProfile()..userId = request.value;
    }

    final result = results.first['user_profile']!;
    return UserProfile(
      userId: result['user_id'],
      name: result['name'],
      avatar: result['avatar'],
      bio: result['bio'],
      gender: UserProfile_Gender.valueOf(result['gender']),
    );
  }

  @override
  Future<Empty> update(
      ServiceCall call, UpdateUserProfileRequest request) async {
    final auth = single<Auth>();
    final accessToken = await auth.getAccessToken(call.clientMetadata);

    // Validate the access token.
    auth.validate(accessToken: accessToken);

    final Map<String, dynamic> variables = {};
    final List<String> fields = [];

    // Using request build the variables and fields.
    if (request.hasName()) {
      variables['name'] = request.name;
      fields.add('name = @name');
    }
    if (request.hasBio()) {
      variables['bio'] = request.bio;
      fields.add('bio = @bio');
    }
    if (request.hasBirthday() && request.birthday.toString().length == 8) {
      variables['birthday'] = request.birthday;
      fields.add('birthday = @birthday');
    }
    if (request.hasGender()) {
      variables['gender'] = request.gender.value;
      fields.add('gender = @gender');
    }

    // If fields is empty.
    if (fields.isEmpty) {
      return Empty();
    }

    // Update the user profile.
    final database = await single<DatabaseConnectionPool>().getConnection();
    await database.execute(
      'UPDATE user_profiles SET ${fields.join(', ')} WHERE user_id = @userId',
      substitutionValues: {
        'userId': accessToken!.userId,
        ...variables,
      },
    );

    return Empty();
  }
}
