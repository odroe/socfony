///
//  Generated code. Do not modify.
//  source: socfony.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $3;

import 'socfony.pbenum.dart';

export 'socfony.pbenum.dart';

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

class AccessTokenEntity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'AccessTokenEntity',
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
            : 'userId')
    ..aOM<$3.Timestamp>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'expiredAt',
        subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'refreshExpiredAt',
        subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false;

  AccessTokenEntity._() : super();
  factory AccessTokenEntity({
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
  factory AccessTokenEntity.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AccessTokenEntity.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AccessTokenEntity clone() => AccessTokenEntity()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AccessTokenEntity copyWith(void Function(AccessTokenEntity) updates) =>
      super.copyWith((message) => updates(message as AccessTokenEntity))
          as AccessTokenEntity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccessTokenEntity create() => AccessTokenEntity._();
  AccessTokenEntity createEmptyInstance() => create();
  static $pb.PbList<AccessTokenEntity> createRepeated() =>
      $pb.PbList<AccessTokenEntity>();
  @$core.pragma('dart2js:noInline')
  static AccessTokenEntity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AccessTokenEntity>(create);
  static AccessTokenEntity? _defaultInstance;

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

class UserUpdatePhoneRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserUpdatePhoneRequest',
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
            : 'oldPhoneCode')
    ..hasRequiredFields = false;

  UserUpdatePhoneRequest._() : super();
  factory UserUpdatePhoneRequest({
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
  factory UserUpdatePhoneRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserUpdatePhoneRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserUpdatePhoneRequest clone() =>
      UserUpdatePhoneRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserUpdatePhoneRequest copyWith(
          void Function(UserUpdatePhoneRequest) updates) =>
      super.copyWith((message) => updates(message as UserUpdatePhoneRequest))
          as UserUpdatePhoneRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserUpdatePhoneRequest create() => UserUpdatePhoneRequest._();
  UserUpdatePhoneRequest createEmptyInstance() => create();
  static $pb.PbList<UserUpdatePhoneRequest> createRepeated() =>
      $pb.PbList<UserUpdatePhoneRequest>();
  @$core.pragma('dart2js:noInline')
  static UserUpdatePhoneRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserUpdatePhoneRequest>(create);
  static UserUpdatePhoneRequest? _defaultInstance;

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

enum UserFindOneRequest_Kind { id, phone, name, notSet }

class UserFindOneRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, UserFindOneRequest_Kind>
      _UserFindOneRequest_KindByTag = {
    1: UserFindOneRequest_Kind.id,
    2: UserFindOneRequest_Kind.phone,
    3: UserFindOneRequest_Kind.name,
    0: UserFindOneRequest_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserFindOneRequest',
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

  UserFindOneRequest._() : super();
  factory UserFindOneRequest({
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
  factory UserFindOneRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserFindOneRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserFindOneRequest clone() => UserFindOneRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserFindOneRequest copyWith(void Function(UserFindOneRequest) updates) =>
      super.copyWith((message) => updates(message as UserFindOneRequest))
          as UserFindOneRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserFindOneRequest create() => UserFindOneRequest._();
  UserFindOneRequest createEmptyInstance() => create();
  static $pb.PbList<UserFindOneRequest> createRepeated() =>
      $pb.PbList<UserFindOneRequest>();
  @$core.pragma('dart2js:noInline')
  static UserFindOneRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFindOneRequest>(create);
  static UserFindOneRequest? _defaultInstance;

  UserFindOneRequest_Kind whichKind() =>
      _UserFindOneRequest_KindByTag[$_whichOneof(0)]!;
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

class UserFindManyRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserFindManyRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..pc<UserFindOneRequest>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'conditions',
        $pb.PbFieldType.PM,
        subBuilder: UserFindOneRequest.create)
    ..hasRequiredFields = false;

  UserFindManyRequest._() : super();
  factory UserFindManyRequest({
    $core.Iterable<UserFindOneRequest>? conditions,
  }) {
    final _result = create();
    if (conditions != null) {
      _result.conditions.addAll(conditions);
    }
    return _result;
  }
  factory UserFindManyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserFindManyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserFindManyRequest clone() => UserFindManyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserFindManyRequest copyWith(void Function(UserFindManyRequest) updates) =>
      super.copyWith((message) => updates(message as UserFindManyRequest))
          as UserFindManyRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserFindManyRequest create() => UserFindManyRequest._();
  UserFindManyRequest createEmptyInstance() => create();
  static $pb.PbList<UserFindManyRequest> createRepeated() =>
      $pb.PbList<UserFindManyRequest>();
  @$core.pragma('dart2js:noInline')
  static UserFindManyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserFindManyRequest>(create);
  static UserFindManyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserFindOneRequest> get conditions => $_getList(0);
}

class UserSearchRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserSearchRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'keyword')
    ..a<$core.int>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'offset',
        $pb.PbFieldType.O3)
    ..a<$core.int>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'limit',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  UserSearchRequest._() : super();
  factory UserSearchRequest({
    $core.String? keyword,
    $core.int? offset,
    $core.int? limit,
  }) {
    final _result = create();
    if (keyword != null) {
      _result.keyword = keyword;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory UserSearchRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserSearchRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserSearchRequest clone() => UserSearchRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserSearchRequest copyWith(void Function(UserSearchRequest) updates) =>
      super.copyWith((message) => updates(message as UserSearchRequest))
          as UserSearchRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserSearchRequest create() => UserSearchRequest._();
  UserSearchRequest createEmptyInstance() => create();
  static $pb.PbList<UserSearchRequest> createRepeated() =>
      $pb.PbList<UserSearchRequest>();
  @$core.pragma('dart2js:noInline')
  static UserSearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSearchRequest>(create);
  static UserSearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get keyword => $_getSZ(0);
  @$pb.TagNumber(1)
  set keyword($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKeyword() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyword() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class UserEntity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserEntity',
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
            : 'phone')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOM<$3.Timestamp>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'createdAt',
        subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false;

  UserEntity._() : super();
  factory UserEntity({
    $core.String? id,
    $core.String? phone,
    $core.String? name,
    $3.Timestamp? createdAt,
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
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory UserEntity.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserEntity.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserEntity clone() => UserEntity()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserEntity copyWith(void Function(UserEntity) updates) =>
      super.copyWith((message) => updates(message as UserEntity))
          as UserEntity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserEntity create() => UserEntity._();
  UserEntity createEmptyInstance() => create();
  static $pb.PbList<UserEntity> createRepeated() => $pb.PbList<UserEntity>();
  @$core.pragma('dart2js:noInline')
  static UserEntity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserEntity>(create);
  static UserEntity? _defaultInstance;

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

class UserEntityList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserEntityList',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..pc<UserEntity>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'users',
        $pb.PbFieldType.PM,
        subBuilder: UserEntity.create)
    ..hasRequiredFields = false;

  UserEntityList._() : super();
  factory UserEntityList({
    $core.Iterable<UserEntity>? users,
  }) {
    final _result = create();
    if (users != null) {
      _result.users.addAll(users);
    }
    return _result;
  }
  factory UserEntityList.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserEntityList.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserEntityList clone() => UserEntityList()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserEntityList copyWith(void Function(UserEntityList) updates) =>
      super.copyWith((message) => updates(message as UserEntityList))
          as UserEntityList; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserEntityList create() => UserEntityList._();
  UserEntityList createEmptyInstance() => create();
  static $pb.PbList<UserEntityList> createRepeated() =>
      $pb.PbList<UserEntityList>();
  @$core.pragma('dart2js:noInline')
  static UserEntityList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserEntityList>(create);
  static UserEntityList? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserEntity> get users => $_getList(0);
}

class UserProfileUpdateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserProfileUpdateRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'avatar')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'bio')
    ..a<$core.int>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'birthday',
        $pb.PbFieldType.O3)
    ..e<UserProfileEntity_Gender>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'gender',
        $pb.PbFieldType.OE,
        defaultOrMaker: UserProfileEntity_Gender.woman,
        valueOf: UserProfileEntity_Gender.valueOf,
        enumValues: UserProfileEntity_Gender.values)
    ..hasRequiredFields = false;

  UserProfileUpdateRequest._() : super();
  factory UserProfileUpdateRequest({
    $core.String? avatar,
    $core.String? name,
    $core.String? bio,
    $core.int? birthday,
    UserProfileEntity_Gender? gender,
  }) {
    final _result = create();
    if (avatar != null) {
      _result.avatar = avatar;
    }
    if (name != null) {
      _result.name = name;
    }
    if (bio != null) {
      _result.bio = bio;
    }
    if (birthday != null) {
      _result.birthday = birthday;
    }
    if (gender != null) {
      _result.gender = gender;
    }
    return _result;
  }
  factory UserProfileUpdateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserProfileUpdateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserProfileUpdateRequest clone() =>
      UserProfileUpdateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserProfileUpdateRequest copyWith(
          void Function(UserProfileUpdateRequest) updates) =>
      super.copyWith((message) => updates(message as UserProfileUpdateRequest))
          as UserProfileUpdateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserProfileUpdateRequest create() => UserProfileUpdateRequest._();
  UserProfileUpdateRequest createEmptyInstance() => create();
  static $pb.PbList<UserProfileUpdateRequest> createRepeated() =>
      $pb.PbList<UserProfileUpdateRequest>();
  @$core.pragma('dart2js:noInline')
  static UserProfileUpdateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserProfileUpdateRequest>(create);
  static UserProfileUpdateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get avatar => $_getSZ(0);
  @$pb.TagNumber(1)
  set avatar($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAvatar() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvatar() => clearField(1);

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
  $core.String get bio => $_getSZ(2);
  @$pb.TagNumber(3)
  set bio($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasBio() => $_has(2);
  @$pb.TagNumber(3)
  void clearBio() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get birthday => $_getIZ(3);
  @$pb.TagNumber(4)
  set birthday($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasBirthday() => $_has(3);
  @$pb.TagNumber(4)
  void clearBirthday() => clearField(4);

  @$pb.TagNumber(5)
  UserProfileEntity_Gender get gender => $_getN(4);
  @$pb.TagNumber(5)
  set gender(UserProfileEntity_Gender v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasGender() => $_has(4);
  @$pb.TagNumber(5)
  void clearGender() => clearField(5);
}

class UserProfileEntity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserProfileEntity',
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
            : 'avatar')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'bio')
    ..a<$core.int>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'birthday',
        $pb.PbFieldType.O3)
    ..e<UserProfileEntity_Gender>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'gender',
        $pb.PbFieldType.OE,
        defaultOrMaker: UserProfileEntity_Gender.woman,
        valueOf: UserProfileEntity_Gender.valueOf,
        enumValues: UserProfileEntity_Gender.values)
    ..hasRequiredFields = false;

  UserProfileEntity._() : super();
  factory UserProfileEntity({
    $core.String? id,
    $core.String? name,
    $core.String? avatar,
    $core.String? bio,
    $core.int? birthday,
    UserProfileEntity_Gender? gender,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (avatar != null) {
      _result.avatar = avatar;
    }
    if (bio != null) {
      _result.bio = bio;
    }
    if (birthday != null) {
      _result.birthday = birthday;
    }
    if (gender != null) {
      _result.gender = gender;
    }
    return _result;
  }
  factory UserProfileEntity.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserProfileEntity.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserProfileEntity clone() => UserProfileEntity()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserProfileEntity copyWith(void Function(UserProfileEntity) updates) =>
      super.copyWith((message) => updates(message as UserProfileEntity))
          as UserProfileEntity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserProfileEntity create() => UserProfileEntity._();
  UserProfileEntity createEmptyInstance() => create();
  static $pb.PbList<UserProfileEntity> createRepeated() =>
      $pb.PbList<UserProfileEntity>();
  @$core.pragma('dart2js:noInline')
  static UserProfileEntity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserProfileEntity>(create);
  static UserProfileEntity? _defaultInstance;

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
  $core.String get avatar => $_getSZ(2);
  @$pb.TagNumber(3)
  set avatar($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAvatar() => $_has(2);
  @$pb.TagNumber(3)
  void clearAvatar() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get bio => $_getSZ(3);
  @$pb.TagNumber(4)
  set bio($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasBio() => $_has(3);
  @$pb.TagNumber(4)
  void clearBio() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get birthday => $_getIZ(4);
  @$pb.TagNumber(5)
  set birthday($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasBirthday() => $_has(4);
  @$pb.TagNumber(5)
  void clearBirthday() => clearField(5);

  @$pb.TagNumber(6)
  UserProfileEntity_Gender get gender => $_getN(5);
  @$pb.TagNumber(6)
  set gender(UserProfileEntity_Gender v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => clearField(6);
}

enum CreateStorageLinkRequest_Type { image, video, audio, notSet }

class CreateStorageLinkRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, CreateStorageLinkRequest_Type>
      _CreateStorageLinkRequest_TypeByTag = {
    1: CreateStorageLinkRequest_Type.image,
    2: CreateStorageLinkRequest_Type.video,
    3: CreateStorageLinkRequest_Type.audio,
    0: CreateStorageLinkRequest_Type.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateStorageLinkRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..e<StorageImageType>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'image',
        $pb.PbFieldType.OE,
        defaultOrMaker: StorageImageType.jpeg,
        valueOf: StorageImageType.valueOf,
        enumValues: StorageImageType.values)
    ..e<StorageVideoType>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'video',
        $pb.PbFieldType.OE,
        defaultOrMaker: StorageVideoType.mp4,
        valueOf: StorageVideoType.valueOf,
        enumValues: StorageVideoType.values)
    ..e<StorageAudioType>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'audio',
        $pb.PbFieldType.OE,
        defaultOrMaker: StorageAudioType.mp3,
        valueOf: StorageAudioType.valueOf,
        enumValues: StorageAudioType.values)
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'md5')
    ..a<$core.int>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'length',
        $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  CreateStorageLinkRequest._() : super();
  factory CreateStorageLinkRequest({
    StorageImageType? image,
    StorageVideoType? video,
    StorageAudioType? audio,
    $core.String? md5,
    $core.int? length,
  }) {
    final _result = create();
    if (image != null) {
      _result.image = image;
    }
    if (video != null) {
      _result.video = video;
    }
    if (audio != null) {
      _result.audio = audio;
    }
    if (md5 != null) {
      _result.md5 = md5;
    }
    if (length != null) {
      _result.length = length;
    }
    return _result;
  }
  factory CreateStorageLinkRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateStorageLinkRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateStorageLinkRequest clone() =>
      CreateStorageLinkRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateStorageLinkRequest copyWith(
          void Function(CreateStorageLinkRequest) updates) =>
      super.copyWith((message) => updates(message as CreateStorageLinkRequest))
          as CreateStorageLinkRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateStorageLinkRequest create() => CreateStorageLinkRequest._();
  CreateStorageLinkRequest createEmptyInstance() => create();
  static $pb.PbList<CreateStorageLinkRequest> createRepeated() =>
      $pb.PbList<CreateStorageLinkRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateStorageLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateStorageLinkRequest>(create);
  static CreateStorageLinkRequest? _defaultInstance;

  CreateStorageLinkRequest_Type whichType() =>
      _CreateStorageLinkRequest_TypeByTag[$_whichOneof(0)]!;
  void clearType() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  StorageImageType get image => $_getN(0);
  @$pb.TagNumber(1)
  set image(StorageImageType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasImage() => $_has(0);
  @$pb.TagNumber(1)
  void clearImage() => clearField(1);

  @$pb.TagNumber(2)
  StorageVideoType get video => $_getN(1);
  @$pb.TagNumber(2)
  set video(StorageVideoType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVideo() => $_has(1);
  @$pb.TagNumber(2)
  void clearVideo() => clearField(2);

  @$pb.TagNumber(3)
  StorageAudioType get audio => $_getN(2);
  @$pb.TagNumber(3)
  set audio(StorageAudioType v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAudio() => $_has(2);
  @$pb.TagNumber(3)
  void clearAudio() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get md5 => $_getSZ(3);
  @$pb.TagNumber(4)
  set md5($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMd5() => $_has(3);
  @$pb.TagNumber(4)
  void clearMd5() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get length => $_getIZ(4);
  @$pb.TagNumber(5)
  set length($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasLength() => $_has(4);
  @$pb.TagNumber(5)
  void clearLength() => clearField(5);
}

class GetStorageLinkRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'GetStorageLinkRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'key')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'query')
    ..hasRequiredFields = false;

  GetStorageLinkRequest._() : super();
  factory GetStorageLinkRequest({
    $core.String? key,
    $core.String? query,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (query != null) {
      _result.query = query;
    }
    return _result;
  }
  factory GetStorageLinkRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetStorageLinkRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetStorageLinkRequest clone() =>
      GetStorageLinkRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetStorageLinkRequest copyWith(
          void Function(GetStorageLinkRequest) updates) =>
      super.copyWith((message) => updates(message as GetStorageLinkRequest))
          as GetStorageLinkRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetStorageLinkRequest create() => GetStorageLinkRequest._();
  GetStorageLinkRequest createEmptyInstance() => create();
  static $pb.PbList<GetStorageLinkRequest> createRepeated() =>
      $pb.PbList<GetStorageLinkRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStorageLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStorageLinkRequest>(create);
  static GetStorageLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);
}
