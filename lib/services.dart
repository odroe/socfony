// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/services/tencent_cloud.service.dart';

import 'services/access_token.service.dart';
import 'services/moment.service.dart';
import 'services/user.service.dart';
import 'services/user_profile.service.dart';

final List<Service> services = <Service>[
  AccessTokenService(),
  UserService(),
  UserProfileService(),
  TencentCloudService(),
  MomentService(),
];
