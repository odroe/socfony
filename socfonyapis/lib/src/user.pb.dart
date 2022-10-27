///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'user.pbenum.dart';

export 'user.pbenum.dart';

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'User',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
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
            : 'login')
    ..aOS(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'name')
    ..aOS(
        4,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'bio')
    ..aOS(
        5,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'avatar')
    ..e<UserSex>(
        6,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'sex',
        $pb.PbFieldType.OE,
        defaultOrMaker: UserSex.male,
        valueOf: UserSex.valueOf,
        enumValues: UserSex.values)
    ..a<$core.int>(
        7,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'birthday',
        $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(
        8,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'createdAt',
        protoName: 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(
        9,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'updatedAt',
        protoName: 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  User._() : super();
  factory User({
    $core.String? id,
    $core.String? login,
    $core.String? name,
    $core.String? bio,
    $core.String? avatar,
    UserSex? sex,
    $core.int? birthday,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (login != null) {
      _result.login = login;
    }
    if (name != null) {
      _result.name = name;
    }
    if (bio != null) {
      _result.bio = bio;
    }
    if (avatar != null) {
      _result.avatar = avatar;
    }
    if (sex != null) {
      _result.sex = sex;
    }
    if (birthday != null) {
      _result.birthday = birthday;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory User.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User))
          as User; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

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
  $core.String get login => $_getSZ(1);
  @$pb.TagNumber(2)
  set login($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLogin() => $_has(1);
  @$pb.TagNumber(2)
  void clearLogin() => clearField(2);

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
  $core.String get avatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set avatar($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvatar() => clearField(5);

  @$pb.TagNumber(6)
  UserSex get sex => $_getN(5);
  @$pb.TagNumber(6)
  set sex(UserSex v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSex() => $_has(5);
  @$pb.TagNumber(6)
  void clearSex() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get birthday => $_getIZ(6);
  @$pb.TagNumber(7)
  set birthday($core.int v) {
    $_setSignedInt32(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasBirthday() => $_has(6);
  @$pb.TagNumber(7)
  void clearBirthday() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get createdAt => $_getN(7);
  @$pb.TagNumber(8)
  set createdAt($1.Timestamp v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureCreatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $1.Timestamp get updatedAt => $_getN(8);
  @$pb.TagNumber(9)
  set updatedAt($1.Timestamp v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureUpdatedAt() => $_ensure(8);
}

enum UserWhereUniqueRequest_Where { id, login, notSet }

class UserWhereUniqueRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, UserWhereUniqueRequest_Where>
      _UserWhereUniqueRequest_WhereByTag = {
    1: UserWhereUniqueRequest_Where.id,
    2: UserWhereUniqueRequest_Where.login,
    0: UserWhereUniqueRequest_Where.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'UserWhereUniqueRequest',
      package: const $pb.PackageName(
          $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'id')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'login')
    ..hasRequiredFields = false;

  UserWhereUniqueRequest._() : super();
  factory UserWhereUniqueRequest({
    $core.String? id,
    $core.String? login,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (login != null) {
      _result.login = login;
    }
    return _result;
  }
  factory UserWhereUniqueRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UserWhereUniqueRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UserWhereUniqueRequest clone() =>
      UserWhereUniqueRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UserWhereUniqueRequest copyWith(
          void Function(UserWhereUniqueRequest) updates) =>
      super.copyWith((message) => updates(message as UserWhereUniqueRequest))
          as UserWhereUniqueRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserWhereUniqueRequest create() => UserWhereUniqueRequest._();
  UserWhereUniqueRequest createEmptyInstance() => create();
  static $pb.PbList<UserWhereUniqueRequest> createRepeated() =>
      $pb.PbList<UserWhereUniqueRequest>();
  @$core.pragma('dart2js:noInline')
  static UserWhereUniqueRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserWhereUniqueRequest>(create);
  static UserWhereUniqueRequest? _defaultInstance;

  UserWhereUniqueRequest_Where whichWhere() =>
      _UserWhereUniqueRequest_WhereByTag[$_whichOneof(0)]!;
  void clearWhere() => clearField($_whichOneof(0));

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
  $core.String get login => $_getSZ(1);
  @$pb.TagNumber(2)
  set login($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLogin() => $_has(1);
  @$pb.TagNumber(2)
  void clearLogin() => clearField(2);
}
