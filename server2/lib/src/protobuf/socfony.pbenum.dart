///
//  Generated code. Do not modify.
//  source: socfony.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class StorageImageType extends $pb.ProtobufEnum {
  static const StorageImageType jpeg = StorageImageType._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'jpeg');
  static const StorageImageType png = StorageImageType._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'png');
  static const StorageImageType gif = StorageImageType._(
      2,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'gif');
  static const StorageImageType webp = StorageImageType._(
      3,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'webp');

  static const $core.List<StorageImageType> values = <StorageImageType>[
    jpeg,
    png,
    gif,
    webp,
  ];

  static final $core.Map<$core.int, StorageImageType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static StorageImageType? valueOf($core.int value) => _byValue[value];

  const StorageImageType._($core.int v, $core.String n) : super(v, n);
}

class StorageVideoType extends $pb.ProtobufEnum {
  static const StorageVideoType mp4 = StorageVideoType._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'mp4');
  static const StorageVideoType webm = StorageVideoType._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'webm');

  static const $core.List<StorageVideoType> values = <StorageVideoType>[
    mp4,
    webm,
  ];

  static final $core.Map<$core.int, StorageVideoType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static StorageVideoType? valueOf($core.int value) => _byValue[value];

  const StorageVideoType._($core.int v, $core.String n) : super(v, n);
}

class StorageAudioType extends $pb.ProtobufEnum {
  static const StorageAudioType mp3 = StorageAudioType._(
      0,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'mp3');
  static const StorageAudioType wav = StorageAudioType._(
      1,
      const $core.bool.fromEnvironment('protobuf.omit_enum_names')
          ? ''
          : 'wav');

  static const $core.List<StorageAudioType> values = <StorageAudioType>[
    mp3,
    wav,
  ];

  static final $core.Map<$core.int, StorageAudioType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static StorageAudioType? valueOf($core.int value) => _byValue[value];

  const StorageAudioType._($core.int v, $core.String n) : super(v, n);
}

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
