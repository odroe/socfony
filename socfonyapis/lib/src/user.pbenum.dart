///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class User_Sex extends $pb.ProtobufEnum {
  static const User_Sex male = User_Sex._(
      0, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'male');
  static const User_Sex fremale = User_Sex._(1,
      $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'fremale');
  static const User_Sex hermaphrodite = User_Sex._(
      2,
      $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'hermaphrodite');
  static const User_Sex unknown = User_Sex._(3,
      $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'unknown');

  static const $core.List<User_Sex> values = <User_Sex>[
    male,
    fremale,
    hermaphrodite,
    unknown,
  ];

  static final $core.Map<$core.int, User_Sex> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static User_Sex? valueOf($core.int value) => _byValue[value];

  const User_Sex._($core.int v, $core.String n) : super(v, n);
}
