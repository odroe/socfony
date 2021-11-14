///
//  Generated code. Do not modify.
//  source: socfony.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class UserProfileEntity_Gender extends $pb.ProtobufEnum {
  static const UserProfileEntity_Gender woman = UserProfileEntity_Gender._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'woman');
  static const UserProfileEntity_Gender man = UserProfileEntity_Gender._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'man');
  static const UserProfileEntity_Gender unknown = UserProfileEntity_Gender._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'unknown');

  static const $core.List<UserProfileEntity_Gender> values =
      <UserProfileEntity_Gender>[
    woman,
    man,
    unknown,
  ];

  static final $core.Map<$core.int, UserProfileEntity_Gender> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static UserProfileEntity_Gender? valueOf($core.int value) => _byValue[value];

  const UserProfileEntity_Gender._($core.int v, $core.String n) : super(v, n);
}
