// Copyright (c) 2021, Odroe Inc. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:grpc/grpc.dart';
import 'package:server/get_federation_token.dart';
import 'package:server/protos/google/protobuf/empty.pb.dart';
import 'package:server/protos/tencent_cloud.pbgrpc.dart';
import 'package:single/single.dart';

import '../auth.dart';

class TencentCloudService extends TencentCloudServiceBase {
  @override
  Future<TencentCloudCredentials> getFederationToken(
      ServiceCall call, Empty request) async {
    final accessToken =
        await single<Auth>().getAccessToken(call.clientMetadata);

    return await single<GetFederationToken>().token(accessToken?.userId);
  }
}
