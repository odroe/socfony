///
//  Generated code. Do not modify.
//  source: access-token.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'access-token.pb.dart' as $0;
export 'access-token.pb.dart';

class AccessTokenServiceClient extends $grpc.Client {
  static final _$create = $grpc.ClientMethod<$0.CreateAccessTokenRequest,
          $0.CreateAccessTokenResponse>(
      '/odroe.socfony.AccessTokenService/Create',
      ($0.CreateAccessTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateAccessTokenResponse.fromBuffer(value));

  AccessTokenServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.CreateAccessTokenResponse> create(
      $0.CreateAccessTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }
}

abstract class AccessTokenServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.AccessTokenService';

  AccessTokenServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateAccessTokenRequest,
            $0.CreateAccessTokenResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateAccessTokenRequest.fromBuffer(value),
        ($0.CreateAccessTokenResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CreateAccessTokenResponse> create_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateAccessTokenRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$0.CreateAccessTokenResponse> create(
      $grpc.ServiceCall call, $0.CreateAccessTokenRequest request);
}
