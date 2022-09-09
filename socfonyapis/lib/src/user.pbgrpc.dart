///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $4;
import 'google/protobuf/wrappers.pb.dart' as $1;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$find = $grpc.ClientMethod<$4.FindUserRequest, $4.User>(
      '/odroe.socfony.UserService/Find',
      ($4.FindUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.User.fromBuffer(value));
  static final _$updateAvatar = $grpc.ClientMethod<$1.StringValue, $4.User>(
      '/odroe.socfony.UserService/UpdateAvatar',
      ($1.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.User.fromBuffer(value));
  static final _$updateName = $grpc.ClientMethod<$1.StringValue, $4.User>(
      '/odroe.socfony.UserService/UpdateName',
      ($1.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.User.fromBuffer(value));
  static final _$updatePhone =
      $grpc.ClientMethod<$4.UpdateUserPhoneRequest, $4.User>(
          '/odroe.socfony.UserService/UpdatePhone',
          ($4.UpdateUserPhoneRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.User.fromBuffer(value));
  static final _$update =
      $grpc.ClientMethod<$4.UpdateUserOtherInfoRequest, $4.User>(
          '/odroe.socfony.UserService/Update',
          ($4.UpdateUserOtherInfoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.User.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$4.User> find($4.FindUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$find, request, options: options);
  }

  $grpc.ResponseFuture<$4.User> updateAvatar($1.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAvatar, request, options: options);
  }

  $grpc.ResponseFuture<$4.User> updateName($1.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateName, request, options: options);
  }

  $grpc.ResponseFuture<$4.User> updatePhone($4.UpdateUserPhoneRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePhone, request, options: options);
  }

  $grpc.ResponseFuture<$4.User> update($4.UpdateUserOtherInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.FindUserRequest, $4.User>(
        'Find',
        find_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.FindUserRequest.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.StringValue, $4.User>(
        'UpdateAvatar',
        updateAvatar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.StringValue, $4.User>(
        'UpdateName',
        updateName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UpdateUserPhoneRequest, $4.User>(
        'UpdatePhone',
        updatePhone_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UpdateUserPhoneRequest.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UpdateUserOtherInfoRequest, $4.User>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.UpdateUserOtherInfoRequest.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
  }

  $async.Future<$4.User> find_Pre(
      $grpc.ServiceCall call, $async.Future<$4.FindUserRequest> request) async {
    return find(call, await request);
  }

  $async.Future<$4.User> updateAvatar_Pre(
      $grpc.ServiceCall call, $async.Future<$1.StringValue> request) async {
    return updateAvatar(call, await request);
  }

  $async.Future<$4.User> updateName_Pre(
      $grpc.ServiceCall call, $async.Future<$1.StringValue> request) async {
    return updateName(call, await request);
  }

  $async.Future<$4.User> updatePhone_Pre($grpc.ServiceCall call,
      $async.Future<$4.UpdateUserPhoneRequest> request) async {
    return updatePhone(call, await request);
  }

  $async.Future<$4.User> update_Pre($grpc.ServiceCall call,
      $async.Future<$4.UpdateUserOtherInfoRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$4.User> find(
      $grpc.ServiceCall call, $4.FindUserRequest request);
  $async.Future<$4.User> updateAvatar(
      $grpc.ServiceCall call, $1.StringValue request);
  $async.Future<$4.User> updateName(
      $grpc.ServiceCall call, $1.StringValue request);
  $async.Future<$4.User> updatePhone(
      $grpc.ServiceCall call, $4.UpdateUserPhoneRequest request);
  $async.Future<$4.User> update(
      $grpc.ServiceCall call, $4.UpdateUserOtherInfoRequest request);
}
