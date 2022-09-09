///
//  Generated code. Do not modify.
//  source: access_token.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'access_token.pb.dart' as $2;
import 'google/protobuf/empty.pb.dart' as $3;
export 'access_token.pb.dart';

class AccessTokenServiceClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$2.CreateAccessTokenRequest, $2.AccessToken>(
          '/odroe.socfony.AccessTokenService/Create',
          ($2.CreateAccessTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.AccessToken.fromBuffer(value));
  static final _$refresh = $grpc.ClientMethod<$3.Empty, $2.AccessToken>(
      '/odroe.socfony.AccessTokenService/Refresh',
      ($3.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AccessToken.fromBuffer(value));
  static final _$revoke = $grpc.ClientMethod<$3.Empty, $3.Empty>(
      '/odroe.socfony.AccessTokenService/Revoke',
      ($3.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.Empty.fromBuffer(value));

  AccessTokenServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.AccessToken> create(
      $2.CreateAccessTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.AccessToken> refresh($3.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refresh, request, options: options);
  }

  $grpc.ResponseFuture<$3.Empty> revoke($3.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$revoke, request, options: options);
  }
}

abstract class AccessTokenServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.AccessTokenService';

  AccessTokenServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CreateAccessTokenRequest, $2.AccessToken>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateAccessTokenRequest.fromBuffer(value),
        ($2.AccessToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.Empty, $2.AccessToken>(
        'Refresh',
        refresh_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.Empty.fromBuffer(value),
        ($2.AccessToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.Empty, $3.Empty>(
        'Revoke',
        revoke_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.Empty.fromBuffer(value),
        ($3.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$2.AccessToken> create_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateAccessTokenRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$2.AccessToken> refresh_Pre(
      $grpc.ServiceCall call, $async.Future<$3.Empty> request) async {
    return refresh(call, await request);
  }

  $async.Future<$3.Empty> revoke_Pre(
      $grpc.ServiceCall call, $async.Future<$3.Empty> request) async {
    return revoke(call, await request);
  }

  $async.Future<$2.AccessToken> create(
      $grpc.ServiceCall call, $2.CreateAccessTokenRequest request);
  $async.Future<$2.AccessToken> refresh(
      $grpc.ServiceCall call, $3.Empty request);
  $async.Future<$3.Empty> revoke($grpc.ServiceCall call, $3.Empty request);
}
