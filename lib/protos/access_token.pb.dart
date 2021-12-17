///
//  Generated code. Do not modify.
//  source: access_token.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $3;

class AccessTokenCreateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'AccessTokenCreateRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'com.socfony'),
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
            : 'otp')
    ..hasRequiredFields = false;

  AccessTokenCreateRequest._() : super();
  factory AccessTokenCreateRequest({
    $core.String? phone,
    $core.String? otp,
  }) {
    final _result = create();
    if (phone != null) {
      _result.phone = phone;
    }
    if (otp != null) {
      _result.otp = otp;
    }
    return _result;
  }
  factory AccessTokenCreateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AccessTokenCreateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AccessTokenCreateRequest clone() =>
      AccessTokenCreateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AccessTokenCreateRequest copyWith(
          void Function(AccessTokenCreateRequest) updates) =>
      super.copyWith((message) => updates(message as AccessTokenCreateRequest))
          as AccessTokenCreateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AccessTokenCreateRequest create() => AccessTokenCreateRequest._();
  AccessTokenCreateRequest createEmptyInstance() => create();
  static $pb.PbList<AccessTokenCreateRequest> createRepeated() =>
      $pb.PbList<AccessTokenCreateRequest>();
  @$core.pragma('dart2js:noInline')
  static AccessTokenCreateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AccessTokenCreateRequest>(create);
  static AccessTokenCreateRequest? _defaultInstance;

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
  $core.String get otp => $_getSZ(1);
  @$pb.TagNumber(2)
  set otp($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOtp() => $_has(1);
  @$pb.TagNumber(2)
  void clearOtp() => clearField(2);
}

class AccessTokenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'AccessTokenResponse',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'com.socfony'),
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
            : 'createdAt',
        subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'expiredAt',
        subBuilder: $3.Timestamp.create)
    ..aOM<$3.Timestamp>(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'refreshExpiredAt',
        subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false;

  AccessTokenResponse._() : super();
  factory AccessTokenResponse({
    $core.String? token,
    $core.String? userId,
    $3.Timestamp? createdAt,
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
    if (createdAt != null) {
      _result.createdAt = createdAt;
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
  $3.Timestamp get createdAt => $_getN(2);
  @$pb.TagNumber(3)
  set createdAt($3.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCreatedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatedAt() => clearField(3);
  @$pb.TagNumber(3)
  $3.Timestamp ensureCreatedAt() => $_ensure(2);

  @$pb.TagNumber(4)
  $3.Timestamp get expiredAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiredAt($3.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasExpiredAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiredAt() => clearField(4);
  @$pb.TagNumber(4)
  $3.Timestamp ensureExpiredAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $3.Timestamp get refreshExpiredAt => $_getN(4);
  @$pb.TagNumber(5)
  set refreshExpiredAt($3.Timestamp v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasRefreshExpiredAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearRefreshExpiredAt() => clearField(5);
  @$pb.TagNumber(5)
  $3.Timestamp ensureRefreshExpiredAt() => $_ensure(4);
}
