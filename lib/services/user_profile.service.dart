// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/protos/google/protobuf/wrappers.pb.dart';
import 'package:server/protos/user_profile.pbgrpc.dart';

class UserProfileService extends UserProfileServiceBase {
  @override
  Future<UserProfile> findUnique(ServiceCall call, StringValue request) async {
    final database = single<>();
    // TODO: implement findUnique
    throw UnimplementedError();
  }
}
