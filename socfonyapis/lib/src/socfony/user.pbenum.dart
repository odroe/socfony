///
//  Generated code. Do not modify.
//  source: socfony/user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class User_Gender extends $pb.ProtobufEnum {
  static const User_Gender woman = User_Gender._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'woman');
  static const User_Gender man = User_Gender._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'man');
  static const User_Gender unknown = User_Gender._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'unknown');

  static const $core.List<User_Gender> values = <User_Gender>[
    woman,
    man,
    unknown,
  ];

  static final $core.Map<$core.int, User_Gender> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static User_Gender? valueOf($core.int value) => _byValue[value];

  const User_Gender._($core.int v, $core.String n) : super(v, n);
}
