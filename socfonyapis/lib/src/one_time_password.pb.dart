///
//  Generated code. Do not modify.
//  source: one_time_password.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class OneTimePasswordInput extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'OneTimePasswordInput',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'password')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'secret')
    ..hasRequiredFields = false;

  OneTimePasswordInput._() : super();
  factory OneTimePasswordInput() => create();
  factory OneTimePasswordInput.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OneTimePasswordInput.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OneTimePasswordInput clone() =>
      OneTimePasswordInput()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OneTimePasswordInput copyWith(void Function(OneTimePasswordInput) updates) =>
      super.copyWith((message) => updates(message as OneTimePasswordInput))
          as OneTimePasswordInput; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OneTimePasswordInput create() => OneTimePasswordInput._();
  OneTimePasswordInput createEmptyInstance() => create();
  static $pb.PbList<OneTimePasswordInput> createRepeated() =>
      $pb.PbList<OneTimePasswordInput>();
  @$core.pragma('dart2js:noInline')
  static OneTimePasswordInput getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OneTimePasswordInput>(create);
  static OneTimePasswordInput? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get password => $_getSZ(0);
  @$pb.TagNumber(1)
  set password($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearPassword() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get secret => $_getSZ(1);
  @$pb.TagNumber(2)
  set secret($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSecret() => $_has(1);
  @$pb.TagNumber(2)
  void clearSecret() => clearField(2);
}

class SendOneTimePasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'SendOneTimePasswordRequest',
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
    ..hasRequiredFields = false;

  SendOneTimePasswordRequest._() : super();
  factory SendOneTimePasswordRequest() => create();
  factory SendOneTimePasswordRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SendOneTimePasswordRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SendOneTimePasswordRequest clone() =>
      SendOneTimePasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SendOneTimePasswordRequest copyWith(
          void Function(SendOneTimePasswordRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SendOneTimePasswordRequest))
          as SendOneTimePasswordRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendOneTimePasswordRequest create() => SendOneTimePasswordRequest._();
  SendOneTimePasswordRequest createEmptyInstance() => create();
  static $pb.PbList<SendOneTimePasswordRequest> createRepeated() =>
      $pb.PbList<SendOneTimePasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static SendOneTimePasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendOneTimePasswordRequest>(create);
  static SendOneTimePasswordRequest? _defaultInstance;

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
}

class VerifyOneTimePasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'VerifyOneTimePasswordRequest',
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
    ..aOM<OneTimePasswordInput>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'data',
        subBuilder: OneTimePasswordInput.create)
    ..hasRequiredFields = false;

  VerifyOneTimePasswordRequest._() : super();
  factory VerifyOneTimePasswordRequest() => create();
  factory VerifyOneTimePasswordRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory VerifyOneTimePasswordRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  VerifyOneTimePasswordRequest clone() =>
      VerifyOneTimePasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  VerifyOneTimePasswordRequest copyWith(
          void Function(VerifyOneTimePasswordRequest) updates) =>
      super.copyWith(
              (message) => updates(message as VerifyOneTimePasswordRequest))
          as VerifyOneTimePasswordRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyOneTimePasswordRequest create() =>
      VerifyOneTimePasswordRequest._();
  VerifyOneTimePasswordRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyOneTimePasswordRequest> createRepeated() =>
      $pb.PbList<VerifyOneTimePasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyOneTimePasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyOneTimePasswordRequest>(create);
  static VerifyOneTimePasswordRequest? _defaultInstance;

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
  OneTimePasswordInput get data => $_getN(1);
  @$pb.TagNumber(2)
  set data(OneTimePasswordInput v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
  @$pb.TagNumber(2)
  OneTimePasswordInput ensureData() => $_ensure(1);
}
