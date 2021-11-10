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
      '/odroe.socfony.VerificationCodeService/send',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$sendByAuthenticatedUser =
      $grpc.ClientMethod<$1.Empty, $1.Empty>(
          '/odroe.socfony.VerificationCodeService/sendByAuthenticatedUser',
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
        'send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'sendByAuthenticatedUser',
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
          '/odroe.socfony.AccessTokenService/create',
          ($2.CreateAccessTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.AccessTokenResponse.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/odroe.socfony.AccessTokenService/delete',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$refresh = $grpc.ClientMethod<$1.Empty, $2.AccessTokenResponse>(
      '/odroe.socfony.AccessTokenService/refresh',
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
        'create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateAccessTokenRequest.fromBuffer(value),
        ($2.AccessTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.AccessTokenResponse>(
        'refresh',
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

class UserServiceClient extends $grpc.Client {
  static final _$findOne =
      $grpc.ClientMethod<$2.FindOneUserRequest, $2.UserResponse>(
          '/odroe.socfony.UserService/findOne',
          ($2.FindOneUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UserResponse.fromBuffer(value));
  static final _$findMany =
      $grpc.ClientMethod<$2.FindManyUserRequest, $2.ManyUsersResponse>(
          '/odroe.socfony.UserService/findMany',
          ($2.FindManyUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.ManyUsersResponse.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$0.StringValue, $2.UserResponse>(
      '/odroe.socfony.UserService/update',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UserResponse.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.UserResponse> findOne($2.FindOneUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findOne, request, options: options);
  }

  $grpc.ResponseFuture<$2.ManyUsersResponse> findMany(
      $2.FindManyUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findMany, request, options: options);
  }

  $grpc.ResponseFuture<$2.UserResponse> update($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.FindOneUserRequest, $2.UserResponse>(
        'findOne',
        findOne_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.FindOneUserRequest.fromBuffer(value),
        ($2.UserResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$2.FindManyUserRequest, $2.ManyUsersResponse>(
            'findMany',
            findMany_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.FindManyUserRequest.fromBuffer(value),
            ($2.ManyUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $2.UserResponse>(
        'update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($2.UserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$2.UserResponse> findOne_Pre($grpc.ServiceCall call,
      $async.Future<$2.FindOneUserRequest> request) async {
    return findOne(call, await request);
  }

  $async.Future<$2.ManyUsersResponse> findMany_Pre($grpc.ServiceCall call,
      $async.Future<$2.FindManyUserRequest> request) async {
    return findMany(call, await request);
  }

  $async.Future<$2.UserResponse> update_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return update(call, await request);
  }

  $async.Future<$2.UserResponse> findOne(
      $grpc.ServiceCall call, $2.FindOneUserRequest request);
  $async.Future<$2.ManyUsersResponse> findMany(
      $grpc.ServiceCall call, $2.FindManyUserRequest request);
  $async.Future<$2.UserResponse> update(
      $grpc.ServiceCall call, $0.StringValue request);
}

class UserPhoneSafeServiceClient extends $grpc.Client {
  static final _$update =
      $grpc.ClientMethod<$2.UpdateUserPhoneSafeRequest, $1.Empty>(
          '/odroe.socfony.UserPhoneSafeService/Update',
          ($2.UpdateUserPhoneSafeRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  UserPhoneSafeServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> update($2.UpdateUserPhoneSafeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }
}

abstract class UserPhoneSafeServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserPhoneSafeService';

  UserPhoneSafeServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.UpdateUserPhoneSafeRequest, $1.Empty>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateUserPhoneSafeRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> update_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateUserPhoneSafeRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$1.Empty> update(
      $grpc.ServiceCall call, $2.UpdateUserPhoneSafeRequest request);
}
