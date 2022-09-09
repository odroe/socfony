///
//  Generated code. Do not modify.
//  source: access_token.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'access_token.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
export 'access_token.pb.dart';

class AccessTokenServiceClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$0.CreateAccessTokenRequest, $0.AccessToken>(
          '/odroe.socfony.AccessTokenService/Create',
          ($0.CreateAccessTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.AccessToken.fromBuffer(value));
  static final _$refresh = $grpc.ClientMethod<$1.Empty, $0.AccessToken>(
      '/odroe.socfony.AccessTokenService/Refresh',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AccessToken.fromBuffer(value));
  static final _$revoke = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/odroe.socfony.AccessTokenService/Revoke',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  AccessTokenServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.AccessToken> create(
      $0.CreateAccessTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$0.AccessToken> refresh($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refresh, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> revoke($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$revoke, request, options: options);
  }
}

abstract class AccessTokenServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.AccessTokenService';

  AccessTokenServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateAccessTokenRequest, $0.AccessToken>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateAccessTokenRequest.fromBuffer(value),
        ($0.AccessToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.AccessToken>(
        'Refresh',
        refresh_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.AccessToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'Revoke',
        revoke_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.AccessToken> create_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateAccessTokenRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$0.AccessToken> refresh_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return refresh(call, await request);
  }

  $async.Future<$1.Empty> revoke_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return revoke(call, await request);
  }

  $async.Future<$0.AccessToken> create(
      $grpc.ServiceCall call, $0.CreateAccessTokenRequest request);
  $async.Future<$0.AccessToken> refresh(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> revoke($grpc.ServiceCall call, $1.Empty request);
}
