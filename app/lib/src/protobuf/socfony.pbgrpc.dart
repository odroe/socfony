///
//  Generated code. Do not modify.
//  source: socfony.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'google/protobuf/wrappers.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
import 'socfony.pb.dart' as $2;
export 'socfony.pb.dart';

class VerificationCodeServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$0.StringValue, $1.Empty>(
      '/odroe.socfony.VerificationCodeService/Send',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$sendByAuthenticatedUser =
      $grpc.ClientMethod<$1.Empty, $1.Empty>(
          '/odroe.socfony.VerificationCodeService/SendByAuthenticatedUser',
          ($1.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  VerificationCodeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> send($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> sendByAuthenticatedUser($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendByAuthenticatedUser, request,
        options: options);
  }
}

abstract class VerificationCodeServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.VerificationCodeService';

  VerificationCodeServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.Empty>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'SendByAuthenticatedUser',
        sendByAuthenticatedUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return send(call, await request);
  }

  $async.Future<$1.Empty> sendByAuthenticatedUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return sendByAuthenticatedUser(call, await request);
  }

  $async.Future<$1.Empty> send($grpc.ServiceCall call, $0.StringValue request);
  $async.Future<$1.Empty> sendByAuthenticatedUser(
      $grpc.ServiceCall call, $1.Empty request);
}

class AccessTokenServiceClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$2.CreateAccessTokenRequest, $2.AccessTokenResponse>(
          '/odroe.socfony.AccessTokenService/Create',
          ($2.CreateAccessTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.AccessTokenResponse.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/odroe.socfony.AccessTokenService/Delete',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$refresh = $grpc.ClientMethod<$1.Empty, $2.AccessTokenResponse>(
      '/odroe.socfony.AccessTokenService/Refresh',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $2.AccessTokenResponse.fromBuffer(value));

  AccessTokenServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.AccessTokenResponse> create(
      $2.CreateAccessTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> delete($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$2.AccessTokenResponse> refresh($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refresh, request, options: options);
  }
}

abstract class AccessTokenServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.AccessTokenService';

  AccessTokenServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CreateAccessTokenRequest,
            $2.AccessTokenResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateAccessTokenRequest.fromBuffer(value),
        ($2.AccessTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.AccessTokenResponse>(
        'Refresh',
        refresh_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($2.AccessTokenResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.AccessTokenResponse> create_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateAccessTokenRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return delete(call, await request);
  }

  $async.Future<$2.AccessTokenResponse> refresh_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return refresh(call, await request);
  }

  $async.Future<$2.AccessTokenResponse> create(
      $grpc.ServiceCall call, $2.CreateAccessTokenRequest request);
  $async.Future<$1.Empty> delete($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$2.AccessTokenResponse> refresh(
      $grpc.ServiceCall call, $1.Empty request);
}
