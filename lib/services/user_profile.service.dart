// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/database/connection_pool.dart';
import 'package:server/protos/google/protobuf/wrappers.pb.dart';
import 'package:server/protos/user_profile.pbgrpc.dart';
import 'package:single/single.dart';

class UserProfileService extends UserProfileServiceBase {
  @override
  Future<UserProfile> findUnique(ServiceCall call, StringValue request) async {
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
}
