// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';

import 'services/access_token.service.dart';
import 'services/user.service.dart';
import 'services/user_profile.service.dart';
import 'services/verification_code.service.dart';

final List<Service> services = <Service>[
  AccessTokenService(),
  VerificationCodeService(),
  UserService(),
  UserProfileService(),
];
