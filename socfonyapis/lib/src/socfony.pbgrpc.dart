///
//  Generated code. Do not modify.
//  source: socfony.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'socfony.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
import 'google/protobuf/wrappers.pb.dart' as $2;
export 'socfony.pb.dart';

class AuthServiceClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$0.CreateAccessTokenRequest, $0.AccessToken>(
          '/odroe.socfony.AuthService/Create',
          ($0.CreateAccessTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.AccessToken.fromBuffer(value));
  static final _$refresh = $grpc.ClientMethod<$1.Empty, $0.AccessToken>(
      '/odroe.socfony.AuthService/Refresh',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AccessToken.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/odroe.socfony.AuthService/Delete',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  AuthServiceClient($grpc.ClientChannel channel,
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

  $grpc.ResponseFuture<$1.Empty> delete($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }
}

abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.AuthService';

  AuthServiceBase() {
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
        'Delete',
        delete_Pre,
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

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return delete(call, await request);
  }

  $async.Future<$0.AccessToken> create(
      $grpc.ServiceCall call, $0.CreateAccessTokenRequest request);
  $async.Future<$0.AccessToken> refresh(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> delete($grpc.ServiceCall call, $1.Empty request);
}

class UserServiceClient extends $grpc.Client {
  static final _$find = $grpc.ClientMethod<$2.StringValue, $0.User>(
      '/odroe.socfony.UserService/Find',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$0.UpdateUserRequest, $0.User>(
      '/odroe.socfony.UserService/Update',
      ($0.UpdateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.User> find($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$find, request, options: options);
  }

  $grpc.ResponseFuture<$0.User> update($0.UpdateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.StringValue, $0.User>(
        'Find',
        find_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateUserRequest, $0.User>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateUserRequest.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
  }

  $async.Future<$0.User> find_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return find(call, await request);
  }

  $async.Future<$0.User> update_Pre($grpc.ServiceCall call,
      $async.Future<$0.UpdateUserRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$0.User> find($grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$0.User> update(
      $grpc.ServiceCall call, $0.UpdateUserRequest request);
}

class MomentServiceClient extends $grpc.Client {
  static final _$create = $grpc.ClientMethod<$0.CreateMomentRequest, $0.Moment>(
      '/odroe.socfony.MomentService/Create',
      ($0.CreateMomentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Moment.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$2.StringValue, $1.Empty>(
      '/odroe.socfony.MomentService/Delete',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$hasLiked = $grpc.ClientMethod<$2.StringValue, $2.BoolValue>(
      '/odroe.socfony.MomentService/hasLiked',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));
  static final _$toggleLike = $grpc.ClientMethod<$2.StringValue, $2.BoolValue>(
      '/odroe.socfony.MomentService/toggleLike',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));

  MomentServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Moment> create($0.CreateMomentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> delete($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> hasLiked($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$hasLiked, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> toggleLike($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleLike, request, options: options);
  }
}

abstract class MomentServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.MomentService';

  MomentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateMomentRequest, $0.Moment>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateMomentRequest.fromBuffer(value),
        ($0.Moment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $2.BoolValue>(
        'hasLiked',
        hasLiked_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $2.BoolValue>(
        'toggleLike',
        toggleLike_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
  }

  $async.Future<$0.Moment> create_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateMomentRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return delete(call, await request);
  }

  $async.Future<$2.BoolValue> hasLiked_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return hasLiked(call, await request);
  }

  $async.Future<$2.BoolValue> toggleLike_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return toggleLike(call, await request);
  }

  $async.Future<$0.Moment> create(
      $grpc.ServiceCall call, $0.CreateMomentRequest request);
  $async.Future<$1.Empty> delete(
      $grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$2.BoolValue> hasLiked(
      $grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$2.BoolValue> toggleLike(
      $grpc.ServiceCall call, $2.StringValue request);
}

class PhoneOtpServiceClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$2.StringValue, $1.Empty>(
      '/odroe.socfony.PhoneOtpService/Send',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$verify = $grpc.ClientMethod<$2.StringValue, $2.BoolValue>(
      '/odroe.socfony.PhoneOtpService/Verify',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));

  PhoneOtpServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> send($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> verify($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verify, request, options: options);
  }
}

abstract class PhoneOtpServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.PhoneOtpService';

  PhoneOtpServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.StringValue, $1.Empty>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $2.BoolValue>(
        'Verify',
        verify_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> send_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return send(call, await request);
  }

  $async.Future<$2.BoolValue> verify_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return verify(call, await request);
  }

  $async.Future<$1.Empty> send($grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$2.BoolValue> verify(
      $grpc.ServiceCall call, $2.StringValue request);
}
