///
//  Generated code. Do not modify.
//  source: socfony.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $3;

class AccessTokenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'AccessTokenResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'token')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'userId',
        protoName: 'userId')
    ..aOM<$3.Timestamp>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'expiredAt',
        protoName: 'expiredAt',
        subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'refreshExpiredAt',
        protoName: 'refreshExpiredAt',
        subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false;

  AccessTokenResponse._() : super();
  factory AccessTokenResponse({
    $core.String? token,
    $core.String? userId,
    $3.Timestamp? expiredAt,
    $3.Timestamp? refreshExpiredAt,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (expiredAt != null) {
      _result.expiredAt = expiredAt;
    }
    if (refreshExpiredAt != null) {
      _result.refreshExpiredAt = refreshExpiredAt;
    }
    return _result;
  }
  factory AccessTokenResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AccessTokenResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AccessTokenResponse clone() => AccessTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AccessTokenResponse copyWith(void Function(AccessTokenResponse) updates) =>
      super.copyWith((message) => updates(message as AccessTokenResponse))
          as AccessTokenResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccessTokenResponse create() => AccessTokenResponse._();
  AccessTokenResponse createEmptyInstance() => create();
  static $pb.PbList<AccessTokenResponse> createRepeated() =>
      $pb.PbList<AccessTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static AccessTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AccessTokenResponse>(create);
  static AccessTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $3.Timestamp get expiredAt => $_getN(2);
  @$pb.TagNumber(3)
  set expiredAt($3.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasExpiredAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiredAt() => clearField(3);
  @$pb.TagNumber(3)
  $3.Timestamp ensureExpiredAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.Timestamp get refreshExpiredAt => $_getN(3);
  @$pb.TagNumber(4)
  set refreshExpiredAt($3.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasRefreshExpiredAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshExpiredAt() => clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureRefreshExpiredAt() => $_ensure(3);
}

class CreateAccessTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateAccessTokenRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'phone')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'code')
    ..hasRequiredFields = false;

  CreateAccessTokenRequest._() : super();
  factory CreateAccessTokenRequest({
    $core.String? phone,
    $core.String? code,
  }) {
    final _result = create();
    if (phone != null) {
      _result.phone = phone;
    }
    if (code != null) {
      _result.code = code;
    }
    return _result;
  }
  factory CreateAccessTokenRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateAccessTokenRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateAccessTokenRequest clone() =>
      CreateAccessTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateAccessTokenRequest copyWith(
          void Function(CreateAccessTokenRequest) updates) =>
      super.copyWith((message) => updates(message as CreateAccessTokenRequest))
          as CreateAccessTokenRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateAccessTokenRequest create() => CreateAccessTokenRequest._();
  CreateAccessTokenRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAccessTokenRequest> createRepeated() =>
      $pb.PbList<CreateAccessTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAccessTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateAccessTokenRequest>(create);
  static CreateAccessTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);
}

class UserResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'id')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'phone')
    ..aOM<$3.Timestamp>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'createdAt',
        protoName: 'createdAt',
        subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false;

  UserResponse._() : super();
  factory UserResponse({
    $core.String? id,
    $core.String? name,
    $core.String? phone,
    $3.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory UserResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserResponse clone() => UserResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserResponse copyWith(void Function(UserResponse) updates) =>
      super.copyWith((message) => updates(message as UserResponse))
          as UserResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserResponse create() => UserResponse._();
  UserResponse createEmptyInstance() => create();
  static $pb.PbList<UserResponse> createRepeated() =>
      $pb.PbList<UserResponse>();
  @$core.pragma('dart2js:noInline')
  static UserResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserResponse>(create);
  static UserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phone => $_getSZ(2);
  @$pb.TagNumber(3)
  set phone($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhone() => clearField(3);

  @$pb.TagNumber(4)
  $3.Timestamp get createdAt => $_getN(3);
  @$pb.TagNumber(4)
  set createdAt($3.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureCreatedAt() => $_ensure(3);
}

class ManyUsersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'ManyUsersResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..pc<UserResponse>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'users',
        $pb.PbFieldType.PM,
        subBuilder: UserResponse.create)
    ..hasRequiredFields = false;

  ManyUsersResponse._() : super();
  factory ManyUsersResponse({
    $core.Iterable<UserResponse>? users,
  }) {
    final _result = create();
    if (users != null) {
      _result.users.addAll(users);
    }
    return _result;
  }
  factory ManyUsersResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ManyUsersResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ManyUsersResponse clone() => ManyUsersResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ManyUsersResponse copyWith(void Function(ManyUsersResponse) updates) =>
      super.copyWith((message) => updates(message as ManyUsersResponse))
          as ManyUsersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ManyUsersResponse create() => ManyUsersResponse._();
  ManyUsersResponse createEmptyInstance() => create();
  static $pb.PbList<ManyUsersResponse> createRepeated() =>
      $pb.PbList<ManyUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static ManyUsersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ManyUsersResponse>(create);
  static ManyUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserResponse> get users => $_getList(0);
}

enum FindOneUserRequest_Kind { id, phone, name, notSet }

class FindOneUserRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FindOneUserRequest_Kind>
      _FindOneUserRequest_KindByTag = {
    1: FindOneUserRequest_Kind.id,
    2: FindOneUserRequest_Kind.phone,
    3: FindOneUserRequest_Kind.name,
    0: FindOneUserRequest_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'FindOneUserRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'id')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'phone')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..hasRequiredFields = false;

  FindOneUserRequest._() : super();
  factory FindOneUserRequest({
    $core.String? id,
    $core.String? phone,
    $core.String? name,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory FindOneUserRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FindOneUserRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FindOneUserRequest clone() => FindOneUserRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FindOneUserRequest copyWith(void Function(FindOneUserRequest) updates) =>
      super.copyWith((message) => updates(message as FindOneUserRequest))
          as FindOneUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FindOneUserRequest create() => FindOneUserRequest._();
  FindOneUserRequest createEmptyInstance() => create();
  static $pb.PbList<FindOneUserRequest> createRepeated() =>
      $pb.PbList<FindOneUserRequest>();
  @$core.pragma('dart2js:noInline')
  static FindOneUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindOneUserRequest>(create);
  static FindOneUserRequest? _defaultInstance;

  FindOneUserRequest_Kind whichKind() =>
      _FindOneUserRequest_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get phone => $_getSZ(1);
  @$pb.TagNumber(2)
  set phone($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPhone() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhone() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);
}

class FindManyUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'FindManyUserRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..pc<FindOneUserRequest>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'conditions',
        $pb.PbFieldType.PM,
        subBuilder: FindOneUserRequest.create)
    ..hasRequiredFields = false;

  FindManyUserRequest._() : super();
  factory FindManyUserRequest({
    $core.Iterable<FindOneUserRequest>? conditions,
  }) {
    final _result = create();
    if (conditions != null) {
      _result.conditions.addAll(conditions);
    }
    return _result;
  }
  factory FindManyUserRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FindManyUserRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FindManyUserRequest clone() => FindManyUserRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FindManyUserRequest copyWith(void Function(FindManyUserRequest) updates) =>
      super.copyWith((message) => updates(message as FindManyUserRequest))
          as FindManyUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FindManyUserRequest create() => FindManyUserRequest._();
  FindManyUserRequest createEmptyInstance() => create();
  static $pb.PbList<FindManyUserRequest> createRepeated() =>
      $pb.PbList<FindManyUserRequest>();
  @$core.pragma('dart2js:noInline')
  static FindManyUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindManyUserRequest>(create);
  static FindManyUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FindOneUserRequest> get conditions => $_getList(0);
}

class UpdateUserPhoneSafeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UpdateUserPhoneSafeRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'phone')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'code')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'oldPhoneCode',
        protoName: 'oldPhoneCode')
    ..hasRequiredFields = false;

  UpdateUserPhoneSafeRequest._() : super();
  factory UpdateUserPhoneSafeRequest({
    $core.String? phone,
    $core.String? code,
    $core.String? oldPhoneCode,
  }) {
    final _result = create();
    if (phone != null) {
      _result.phone = phone;
    }
    if (code != null) {
      _result.code = code;
    }
    if (oldPhoneCode != null) {
      _result.oldPhoneCode = oldPhoneCode;
    }
    return _result;
  }
  factory UpdateUserPhoneSafeRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateUserPhoneSafeRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateUserPhoneSafeRequest clone() =>
      UpdateUserPhoneSafeRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateUserPhoneSafeRequest copyWith(
          void Function(UpdateUserPhoneSafeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateUserPhoneSafeRequest))
          as UpdateUserPhoneSafeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateUserPhoneSafeRequest create() => UpdateUserPhoneSafeRequest._();
  UpdateUserPhoneSafeRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateUserPhoneSafeRequest> createRepeated() =>
      $pb.PbList<UpdateUserPhoneSafeRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserPhoneSafeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserPhoneSafeRequest>(create);
  static UpdateUserPhoneSafeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get oldPhoneCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set oldPhoneCode($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOldPhoneCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearOldPhoneCode() => clearField(3);
}
