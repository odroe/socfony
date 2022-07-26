///
//  Generated code. Do not modify.
//  source: socfony.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'socfony/access_token.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
import 'google/protobuf/wrappers.pb.dart' as $2;
import 'socfony/user.pb.dart' as $3;
import 'socfony/moment.pb.dart' as $4;
import 'socfony/phone_one_time_password.pb.dart' as $5;
export 'socfony.pb.dart';

class SocfonyServiceClient extends $grpc.Client {
  static final _$createAccessToken =
      $grpc.ClientMethod<$0.CreateAccessTokenRequest, $0.AccessToken>(
          '/odroe.socfony.SocfonyService/CreateAccessToken',
          ($0.CreateAccessTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.AccessToken.fromBuffer(value));
  static final _$refreshAccessToken =
      $grpc.ClientMethod<$1.Empty, $0.AccessToken>(
          '/odroe.socfony.SocfonyService/RefreshAccessToken',
          ($1.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.AccessToken.fromBuffer(value));
  static final _$deleteAccessToken = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/odroe.socfony.SocfonyService/DeleteAccessToken',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$findUser = $grpc.ClientMethod<$2.StringValue, $3.User>(
      '/odroe.socfony.SocfonyService/FindUser',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.User.fromBuffer(value));
  static final _$updateUser = $grpc.ClientMethod<$3.UpdateUserRequest, $3.User>(
      '/odroe.socfony.SocfonyService/UpdateUser',
      ($3.UpdateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.User.fromBuffer(value));
  static final _$updateUserName = $grpc.ClientMethod<$2.StringValue, $3.User>(
      '/odroe.socfony.SocfonyService/UpdateUserName',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.User.fromBuffer(value));
  static final _$updateUserPhone =
      $grpc.ClientMethod<$3.UpdateUserPhoneRequest, $3.User>(
          '/odroe.socfony.SocfonyService/UpdateUserPhone',
          ($3.UpdateUserPhoneRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $3.User.fromBuffer(value));
  static final _$updateUserAvatar = $grpc.ClientMethod<$2.StringValue, $3.User>(
      '/odroe.socfony.SocfonyService/UpdateUserAvatar',
      ($2.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $3.User.fromBuffer(value));
  static final _$createMoment =
      $grpc.ClientMethod<$4.CreateMomentRequest, $4.Moment>(
          '/odroe.socfony.SocfonyService/CreateMoment',
          ($4.CreateMomentRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $4.Moment.fromBuffer(value));
  static final _$toggleMomentLike =
      $grpc.ClientMethod<$2.StringValue, $2.BoolValue>(
          '/odroe.socfony.SocfonyService/ToggleMomentLike',
          ($2.StringValue value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));
  static final _$sendPhoneOneTimePassword =
      $grpc.ClientMethod<$2.StringValue, $1.Empty>(
          '/odroe.socfony.SocfonyService/SendPhoneOneTimePassword',
          ($2.StringValue value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$checkPhoneOneTimePassword =
      $grpc.ClientMethod<$5.CheckPhoneOneTimePasswordRequest, $2.BoolValue>(
          '/odroe.socfony.SocfonyService/CheckPhoneOneTimePassword',
          ($5.CheckPhoneOneTimePasswordRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));
  static final _$sendPhoneOneTimePassword2auth =
      $grpc.ClientMethod<$1.Empty, $1.Empty>(
          '/odroe.socfony.SocfonyService/SendPhoneOneTimePassword2auth',
          ($1.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$checkPhoneOneTimePassword2auth =
      $grpc.ClientMethod<$2.StringValue, $2.BoolValue>(
          '/odroe.socfony.SocfonyService/CheckPhoneOneTimePassword2auth',
          ($2.StringValue value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.BoolValue.fromBuffer(value));

  SocfonyServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.AccessToken> createAccessToken(
      $0.CreateAccessTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAccessToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.AccessToken> refreshAccessToken($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshAccessToken, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteAccessToken($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAccessToken, request, options: options);
  }

  $grpc.ResponseFuture<$3.User> findUser($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findUser, request, options: options);
  }

  $grpc.ResponseFuture<$3.User> updateUser($3.UpdateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUser, request, options: options);
  }

  $grpc.ResponseFuture<$3.User> updateUserName($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserName, request, options: options);
  }

  $grpc.ResponseFuture<$3.User> updateUserPhone(
      $3.UpdateUserPhoneRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserPhone, request, options: options);
  }

  $grpc.ResponseFuture<$3.User> updateUserAvatar($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserAvatar, request, options: options);
  }

  $grpc.ResponseFuture<$4.Moment> createMoment($4.CreateMomentRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createMoment, request, options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> toggleMomentLike($2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$toggleMomentLike, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> sendPhoneOneTimePassword(
      $2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendPhoneOneTimePassword, request,
        options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> checkPhoneOneTimePassword(
      $5.CheckPhoneOneTimePasswordRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPhoneOneTimePassword, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> sendPhoneOneTimePassword2auth($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendPhoneOneTimePassword2auth, request,
        options: options);
  }

  $grpc.ResponseFuture<$2.BoolValue> checkPhoneOneTimePassword2auth(
      $2.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkPhoneOneTimePassword2auth, request,
        options: options);
  }
}

abstract class SocfonyServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.SocfonyService';

  SocfonyServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateAccessTokenRequest, $0.AccessToken>(
        'CreateAccessToken',
        createAccessToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateAccessTokenRequest.fromBuffer(value),
        ($0.AccessToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.AccessToken>(
        'RefreshAccessToken',
        refreshAccessToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.AccessToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'DeleteAccessToken',
        deleteAccessToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $3.User>(
        'FindUser',
        findUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($3.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UpdateUserRequest, $3.User>(
        'UpdateUser',
        updateUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.UpdateUserRequest.fromBuffer(value),
        ($3.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $3.User>(
        'UpdateUserName',
        updateUserName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($3.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$3.UpdateUserPhoneRequest, $3.User>(
        'UpdateUserPhone',
        updateUserPhone_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $3.UpdateUserPhoneRequest.fromBuffer(value),
        ($3.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $3.User>(
        'UpdateUserAvatar',
        updateUserAvatar_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($3.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.CreateMomentRequest, $4.Moment>(
        'CreateMoment',
        createMoment_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $4.CreateMomentRequest.fromBuffer(value),
        ($4.Moment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $2.BoolValue>(
        'ToggleMomentLike',
        toggleMomentLike_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $1.Empty>(
        'SendPhoneOneTimePassword',
        sendPhoneOneTimePassword_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$5.CheckPhoneOneTimePasswordRequest, $2.BoolValue>(
            'CheckPhoneOneTimePassword',
            checkPhoneOneTimePassword_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $5.CheckPhoneOneTimePasswordRequest.fromBuffer(value),
            ($2.BoolValue value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'SendPhoneOneTimePassword2auth',
        sendPhoneOneTimePassword2auth_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.StringValue, $2.BoolValue>(
        'CheckPhoneOneTimePassword2auth',
        checkPhoneOneTimePassword2auth_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.StringValue.fromBuffer(value),
        ($2.BoolValue value) => value.writeToBuffer()));
  }

  $async.Future<$0.AccessToken> createAccessToken_Pre($grpc.ServiceCall call,
      $async.Future<$0.CreateAccessTokenRequest> request) async {
    return createAccessToken(call, await request);
  }

  $async.Future<$0.AccessToken> refreshAccessToken_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return refreshAccessToken(call, await request);
  }

  $async.Future<$1.Empty> deleteAccessToken_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return deleteAccessToken(call, await request);
  }

  $async.Future<$3.User> findUser_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return findUser(call, await request);
  }

  $async.Future<$3.User> updateUser_Pre($grpc.ServiceCall call,
      $async.Future<$3.UpdateUserRequest> request) async {
    return updateUser(call, await request);
  }

  $async.Future<$3.User> updateUserName_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return updateUserName(call, await request);
  }

  $async.Future<$3.User> updateUserPhone_Pre($grpc.ServiceCall call,
      $async.Future<$3.UpdateUserPhoneRequest> request) async {
    return updateUserPhone(call, await request);
  }

  $async.Future<$3.User> updateUserAvatar_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return updateUserAvatar(call, await request);
  }

  $async.Future<$4.Moment> createMoment_Pre($grpc.ServiceCall call,
      $async.Future<$4.CreateMomentRequest> request) async {
    return createMoment(call, await request);
  }

  $async.Future<$2.BoolValue> toggleMomentLike_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return toggleMomentLike(call, await request);
  }

  $async.Future<$1.Empty> sendPhoneOneTimePassword_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return sendPhoneOneTimePassword(call, await request);
  }

  $async.Future<$2.BoolValue> checkPhoneOneTimePassword_Pre(
      $grpc.ServiceCall call,
      $async.Future<$5.CheckPhoneOneTimePasswordRequest> request) async {
    return checkPhoneOneTimePassword(call, await request);
  }

  $async.Future<$1.Empty> sendPhoneOneTimePassword2auth_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return sendPhoneOneTimePassword2auth(call, await request);
  }

  $async.Future<$2.BoolValue> checkPhoneOneTimePassword2auth_Pre(
      $grpc.ServiceCall call, $async.Future<$2.StringValue> request) async {
    return checkPhoneOneTimePassword2auth(call, await request);
  }

  $async.Future<$0.AccessToken> createAccessToken(
      $grpc.ServiceCall call, $0.CreateAccessTokenRequest request);
  $async.Future<$0.AccessToken> refreshAccessToken(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> deleteAccessToken(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$3.User> findUser(
      $grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$3.User> updateUser(
      $grpc.ServiceCall call, $3.UpdateUserRequest request);
  $async.Future<$3.User> updateUserName(
      $grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$3.User> updateUserPhone(
      $grpc.ServiceCall call, $3.UpdateUserPhoneRequest request);
  $async.Future<$3.User> updateUserAvatar(
      $grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$4.Moment> createMoment(
      $grpc.ServiceCall call, $4.CreateMomentRequest request);
  $async.Future<$2.BoolValue> toggleMomentLike(
      $grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$1.Empty> sendPhoneOneTimePassword(
      $grpc.ServiceCall call, $2.StringValue request);
  $async.Future<$2.BoolValue> checkPhoneOneTimePassword(
      $grpc.ServiceCall call, $5.CheckPhoneOneTimePasswordRequest request);
  $async.Future<$1.Empty> sendPhoneOneTimePassword2auth(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$2.BoolValue> checkPhoneOneTimePassword2auth(
      $grpc.ServiceCall call, $2.StringValue request);
}
