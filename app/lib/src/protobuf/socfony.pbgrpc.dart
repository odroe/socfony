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

class VerificationCodeMutationClient extends $grpc.Client {
  static final _$send = $grpc.ClientMethod<$0.StringValue, $1.Empty>(
      '/odroe.socfony.VerificationCodeMutation/Send',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  VerificationCodeMutationClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> send($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$send, request, options: options);
  }
}

abstract class VerificationCodeMutationServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.VerificationCodeMutation';

  VerificationCodeMutationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StringValue, $1.Empty>(
        'Send',
        send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> send_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return send(call, await request);
  }

  $async.Future<$1.Empty> send($grpc.ServiceCall call, $0.StringValue request);
}

class AccessTokenMutationClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$2.CreateAccessTokenRequest, $2.AccessTokenEntity>(
          '/odroe.socfony.AccessTokenMutation/Create',
          ($2.CreateAccessTokenRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.AccessTokenEntity.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/odroe.socfony.AccessTokenMutation/Delete',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$refresh = $grpc.ClientMethod<$1.Empty, $2.AccessTokenEntity>(
      '/odroe.socfony.AccessTokenMutation/Refresh',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AccessTokenEntity.fromBuffer(value));

  AccessTokenMutationClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.AccessTokenEntity> create(
      $2.CreateAccessTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> delete($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }

  $grpc.ResponseFuture<$2.AccessTokenEntity> refresh($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refresh, request, options: options);
  }
}

abstract class AccessTokenMutationServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.AccessTokenMutation';

  AccessTokenMutationServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.CreateAccessTokenRequest, $2.AccessTokenEntity>(
            'Create',
            create_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.CreateAccessTokenRequest.fromBuffer(value),
            ($2.AccessTokenEntity value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $2.AccessTokenEntity>(
        'Refresh',
        refresh_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($2.AccessTokenEntity value) => value.writeToBuffer()));
  }

  $async.Future<$2.AccessTokenEntity> create_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateAccessTokenRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return delete(call, await request);
  }

  $async.Future<$2.AccessTokenEntity> refresh_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return refresh(call, await request);
  }

  $async.Future<$2.AccessTokenEntity> create(
      $grpc.ServiceCall call, $2.CreateAccessTokenRequest request);
  $async.Future<$1.Empty> delete($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$2.AccessTokenEntity> refresh(
      $grpc.ServiceCall call, $1.Empty request);
}

class UserQueryClient extends $grpc.Client {
  static final _$findOne =
      $grpc.ClientMethod<$2.UserFindOneRequest, $2.UserEntity>(
          '/odroe.socfony.UserQuery/FindOne',
          ($2.UserFindOneRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UserEntity.fromBuffer(value));
  static final _$findMany =
      $grpc.ClientMethod<$2.UserFindManyRequest, $2.UserEntityList>(
          '/odroe.socfony.UserQuery/FindMany',
          ($2.UserFindManyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UserEntityList.fromBuffer(value));
  static final _$search =
      $grpc.ClientMethod<$2.UserSearchRequest, $2.UserEntityList>(
          '/odroe.socfony.UserQuery/Search',
          ($2.UserSearchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UserEntityList.fromBuffer(value));

  UserQueryClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.UserEntity> findOne($2.UserFindOneRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findOne, request, options: options);
  }

  $grpc.ResponseFuture<$2.UserEntityList> findMany(
      $2.UserFindManyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$findMany, request, options: options);
  }

  $grpc.ResponseFuture<$2.UserEntityList> search($2.UserSearchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$search, request, options: options);
  }
}

abstract class UserQueryServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserQuery';

  UserQueryServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.UserFindOneRequest, $2.UserEntity>(
        'FindOne',
        findOne_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UserFindOneRequest.fromBuffer(value),
        ($2.UserEntity value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UserFindManyRequest, $2.UserEntityList>(
        'FindMany',
        findMany_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UserFindManyRequest.fromBuffer(value),
        ($2.UserEntityList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UserSearchRequest, $2.UserEntityList>(
        'Search',
        search_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.UserSearchRequest.fromBuffer(value),
        ($2.UserEntityList value) => value.writeToBuffer()));
  }

  $async.Future<$2.UserEntity> findOne_Pre($grpc.ServiceCall call,
      $async.Future<$2.UserFindOneRequest> request) async {
    return findOne(call, await request);
  }

  $async.Future<$2.UserEntityList> findMany_Pre($grpc.ServiceCall call,
      $async.Future<$2.UserFindManyRequest> request) async {
    return findMany(call, await request);
  }

  $async.Future<$2.UserEntityList> search_Pre($grpc.ServiceCall call,
      $async.Future<$2.UserSearchRequest> request) async {
    return search(call, await request);
  }

  $async.Future<$2.UserEntity> findOne(
      $grpc.ServiceCall call, $2.UserFindOneRequest request);
  $async.Future<$2.UserEntityList> findMany(
      $grpc.ServiceCall call, $2.UserFindManyRequest request);
  $async.Future<$2.UserEntityList> search(
      $grpc.ServiceCall call, $2.UserSearchRequest request);
}

class UserMutationClient extends $grpc.Client {
  static final _$updatePhone =
      $grpc.ClientMethod<$2.UserUpdatePhoneRequest, $2.UserEntity>(
          '/odroe.socfony.UserMutation/UpdatePhone',
          ($2.UserUpdatePhoneRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UserEntity.fromBuffer(value));
  static final _$updateName = $grpc.ClientMethod<$0.StringValue, $2.UserEntity>(
      '/odroe.socfony.UserMutation/UpdateName',
      ($0.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UserEntity.fromBuffer(value));

  UserMutationClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.UserEntity> updatePhone(
      $2.UserUpdatePhoneRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePhone, request, options: options);
  }

  $grpc.ResponseFuture<$2.UserEntity> updateName($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateName, request, options: options);
  }
}

abstract class UserMutationServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserMutation';

  UserMutationServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.UserUpdatePhoneRequest, $2.UserEntity>(
        'UpdatePhone',
        updatePhone_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UserUpdatePhoneRequest.fromBuffer(value),
        ($2.UserEntity value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StringValue, $2.UserEntity>(
        'UpdateName',
        updateName_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($2.UserEntity value) => value.writeToBuffer()));
  }

  $async.Future<$2.UserEntity> updatePhone_Pre($grpc.ServiceCall call,
      $async.Future<$2.UserUpdatePhoneRequest> request) async {
    return updatePhone(call, await request);
  }

  $async.Future<$2.UserEntity> updateName_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return updateName(call, await request);
  }

  $async.Future<$2.UserEntity> updatePhone(
      $grpc.ServiceCall call, $2.UserUpdatePhoneRequest request);
  $async.Future<$2.UserEntity> updateName(
      $grpc.ServiceCall call, $0.StringValue request);
}

class UserProfileQueryClient extends $grpc.Client {
  static final _$find =
      $grpc.ClientMethod<$0.StringValue, $2.UserProfileEntity>(
          '/odroe.socfony.UserProfileQuery/Find',
          ($0.StringValue value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.UserProfileEntity.fromBuffer(value));

  UserProfileQueryClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.UserProfileEntity> find($0.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$find, request, options: options);
  }
}

abstract class UserProfileQueryServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserProfileQuery';

  UserProfileQueryServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.StringValue, $2.UserProfileEntity>(
        'Find',
        find_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value),
        ($2.UserProfileEntity value) => value.writeToBuffer()));
  }

  $async.Future<$2.UserProfileEntity> find_Pre(
      $grpc.ServiceCall call, $async.Future<$0.StringValue> request) async {
    return find(call, await request);
  }

  $async.Future<$2.UserProfileEntity> find(
      $grpc.ServiceCall call, $0.StringValue request);
}

class UserProfileMutationClient extends $grpc.Client {
  static final _$update =
      $grpc.ClientMethod<$2.UserProfileUpdateRequest, $2.UserProfileEntity>(
          '/odroe.socfony.UserProfileMutation/Update',
          ($2.UserProfileUpdateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $2.UserProfileEntity.fromBuffer(value));

  UserProfileMutationClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.UserProfileEntity> update(
      $2.UserProfileUpdateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }
}

abstract class UserProfileMutationServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.UserProfileMutation';

  UserProfileMutationServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$2.UserProfileUpdateRequest, $2.UserProfileEntity>(
            'Update',
            update_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $2.UserProfileUpdateRequest.fromBuffer(value),
            ($2.UserProfileEntity value) => value.writeToBuffer()));
  }

  $async.Future<$2.UserProfileEntity> update_Pre($grpc.ServiceCall call,
      $async.Future<$2.UserProfileUpdateRequest> request) async {
    return update(call, await request);
  }

  $async.Future<$2.UserProfileEntity> update(
      $grpc.ServiceCall call, $2.UserProfileUpdateRequest request);
}

class StorageMutationClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$2.CreateStorageLinkRequest, $0.StringValue>(
          '/odroe.socfony.StorageMutation/Create',
          ($2.CreateStorageLinkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value));

  StorageMutationClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.StringValue> create(
      $2.CreateStorageLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }
}

abstract class StorageMutationServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.StorageMutation';

  StorageMutationServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CreateStorageLinkRequest, $0.StringValue>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateStorageLinkRequest.fromBuffer(value),
        ($0.StringValue value) => value.writeToBuffer()));
  }

  $async.Future<$0.StringValue> create_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateStorageLinkRequest> request) async {
    return create(call, await request);
  }

  $async.Future<$0.StringValue> create(
      $grpc.ServiceCall call, $2.CreateStorageLinkRequest request);
}

class StorageQueryClient extends $grpc.Client {
  static final _$get =
      $grpc.ClientMethod<$2.GetStorageLinkRequest, $0.StringValue>(
          '/odroe.socfony.StorageQuery/Get',
          ($2.GetStorageLinkRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.StringValue.fromBuffer(value));

  StorageQueryClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.StringValue> get($2.GetStorageLinkRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$get, request, options: options);
  }
}

abstract class StorageQueryServiceBase extends $grpc.Service {
  $core.String get $name => 'odroe.socfony.StorageQuery';

  StorageQueryServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.GetStorageLinkRequest, $0.StringValue>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.GetStorageLinkRequest.fromBuffer(value),
        ($0.StringValue value) => value.writeToBuffer()));
  }

  $async.Future<$0.StringValue> get_Pre($grpc.ServiceCall call,
      $async.Future<$2.GetStorageLinkRequest> request) async {
    return get(call, await request);
  }

  $async.Future<$0.StringValue> get(
      $grpc.ServiceCall call, $2.GetStorageLinkRequest request);
}
