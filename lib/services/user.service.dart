// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/protos/user.pbgrpc.dart';

class UserService extends UserServiceBase {
  @override
  Future<UserResponse> findOne(ServiceCall call, UserFindOneRequest request) {
    // TODO: implement findOne
    throw UnimplementedError();
  }
}
