///
//  Generated code. Do not modify.
//  source: moment.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $4;
import 'google/protobuf/timestamp.pb.dart' as $6;

class Moment extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Moment',
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
            : 'title')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'contents')
    ..pPS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'images')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'authorId',
        protoName: 'authorId')
    ..aOM<$4.User>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'author',
        subBuilder: $4.User.create)
    ..aOM<$6.Timestamp>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'createdAt',
        protoName: 'createdAt',
        subBuilder: $6.Timestamp.create)
    ..a<$core.int>(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'favoritesCount',
        $pb.PbFieldType.O3,
        protoName: 'favoritesCount')
    ..a<$core.int>(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'commentsCount',
        $pb.PbFieldType.O3,
        protoName: 'commentsCount')
    ..aOB(
        10,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'isFavorited',
        protoName: 'isFavorited')
    ..hasRequiredFields = false;

  Moment._() : super();
  factory Moment() => create();
  factory Moment.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Moment.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Moment clone() => Moment()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Moment copyWith(void Function(Moment) updates) =>
      super.copyWith((message) => updates(message as Moment))
          as Moment; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Moment create() => Moment._();
  Moment createEmptyInstance() => create();
  static $pb.PbList<Moment> createRepeated() => $pb.PbList<Moment>();
  @$core.pragma('dart2js:noInline')
  static Moment getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Moment>(create);
  static Moment? _defaultInstance;

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
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get contents => $_getSZ(2);
  @$pb.TagNumber(3)
  set contents($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasContents() => $_has(2);
  @$pb.TagNumber(3)
  void clearContents() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get images => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get authorId => $_getSZ(4);
  @$pb.TagNumber(5)
  set authorId($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAuthorId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthorId() => clearField(5);

  @$pb.TagNumber(6)
  $4.User get author => $_getN(5);
  @$pb.TagNumber(6)
  set author($4.User v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasAuthor() => $_has(5);
  @$pb.TagNumber(6)
  void clearAuthor() => clearField(6);
  @$pb.TagNumber(6)
  $4.User ensureAuthor() => $_ensure(5);

  @$pb.TagNumber(7)
  $6.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($6.Timestamp v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $6.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.int get favoritesCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set favoritesCount($core.int v) {
    $_setSignedInt32(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasFavoritesCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearFavoritesCount() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get commentsCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set commentsCount($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasCommentsCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearCommentsCount() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isFavorited => $_getBF(9);
  @$pb.TagNumber(10)
  set isFavorited($core.bool v) {
    $_setBool(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasIsFavorited() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsFavorited() => clearField(10);
}

class CreateMomentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'CreateMomentRequest',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'title')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'contents')
    ..pPS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'images')
    ..hasRequiredFields = false;

  CreateMomentRequest._() : super();
  factory CreateMomentRequest() => create();
  factory CreateMomentRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateMomentRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateMomentRequest clone() => CreateMomentRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateMomentRequest copyWith(void Function(CreateMomentRequest) updates) =>
      super.copyWith((message) => updates(message as CreateMomentRequest))
          as CreateMomentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateMomentRequest create() => CreateMomentRequest._();
  CreateMomentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateMomentRequest> createRepeated() =>
      $pb.PbList<CreateMomentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateMomentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateMomentRequest>(create);
  static CreateMomentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contents => $_getSZ(1);
  @$pb.TagNumber(2)
  set contents($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasContents() => $_has(1);
  @$pb.TagNumber(2)
  void clearContents() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get images => $_getList(2);
}
