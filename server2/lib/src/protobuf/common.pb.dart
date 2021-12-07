///
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Media_Image extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Media.Image',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..pPS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'key')
    ..hasRequiredFields = false;

  Media_Image._() : super();
  factory Media_Image({
    $core.Iterable<$core.String>? key,
  }) {
    final _result = create();
    if (key != null) {
      _result.key.addAll(key);
    }
    return _result;
  }
  factory Media_Image.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Media_Image.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Media_Image clone() => Media_Image()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Media_Image copyWith(void Function(Media_Image) updates) =>
      super.copyWith((message) => updates(message as Media_Image))
          as Media_Image; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Media_Image create() => Media_Image._();
  Media_Image createEmptyInstance() => create();
  static $pb.PbList<Media_Image> createRepeated() => $pb.PbList<Media_Image>();
  @$core.pragma('dart2js:noInline')
  static Media_Image getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Media_Image>(create);
  static Media_Image? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get key => $_getList(0);
}

class Media_Video extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Media.Video',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'src')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'poster')
    ..hasRequiredFields = false;

  Media_Video._() : super();
  factory Media_Video({
    $core.String? src,
    $core.String? poster,
  }) {
    final _result = create();
    if (src != null) {
      _result.src = src;
    }
    if (poster != null) {
      _result.poster = poster;
    }
    return _result;
  }
  factory Media_Video.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Media_Video.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Media_Video clone() => Media_Video()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Media_Video copyWith(void Function(Media_Video) updates) =>
      super.copyWith((message) => updates(message as Media_Video))
          as Media_Video; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Media_Video create() => Media_Video._();
  Media_Video createEmptyInstance() => create();
  static $pb.PbList<Media_Video> createRepeated() => $pb.PbList<Media_Video>();
  @$core.pragma('dart2js:noInline')
  static Media_Video getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Media_Video>(create);
  static Media_Video? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get src => $_getSZ(0);
  @$pb.TagNumber(1)
  set src($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSrc() => $_has(0);
  @$pb.TagNumber(1)
  void clearSrc() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get poster => $_getSZ(1);
  @$pb.TagNumber(2)
  set poster($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPoster() => $_has(1);
  @$pb.TagNumber(2)
  void clearPoster() => clearField(2);
}

class Media_Audio extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Media.Audio',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..aOS(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'src')
    ..aOS(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'poster')
    ..hasRequiredFields = false;

  Media_Audio._() : super();
  factory Media_Audio({
    $core.String? src,
    $core.String? poster,
  }) {
    final _result = create();
    if (src != null) {
      _result.src = src;
    }
    if (poster != null) {
      _result.poster = poster;
    }
    return _result;
  }
  factory Media_Audio.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Media_Audio.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Media_Audio clone() => Media_Audio()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Media_Audio copyWith(void Function(Media_Audio) updates) =>
      super.copyWith((message) => updates(message as Media_Audio))
          as Media_Audio; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Media_Audio create() => Media_Audio._();
  Media_Audio createEmptyInstance() => create();
  static $pb.PbList<Media_Audio> createRepeated() => $pb.PbList<Media_Audio>();
  @$core.pragma('dart2js:noInline')
  static Media_Audio getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Media_Audio>(create);
  static Media_Audio? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get src => $_getSZ(0);
  @$pb.TagNumber(1)
  set src($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSrc() => $_has(0);
  @$pb.TagNumber(1)
  void clearSrc() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get poster => $_getSZ(1);
  @$pb.TagNumber(2)
  set poster($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPoster() => $_has(1);
  @$pb.TagNumber(2)
  void clearPoster() => clearField(2);
}

enum Media_Kind { image, video, audio, notSet }

class Media extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Media_Kind> _Media_KindByTag = {
    1: Media_Kind.image,
    2: Media_Kind.video,
    3: Media_Kind.audio,
    0: Media_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names')
          ? ''
          : 'Media',
      package: const $pb.PackageName(
          const $core.bool.fromEnvironment('protobuf.omit_message_names')
              ? ''
              : 'odroe.socfony'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<Media_Image>(
        1,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'image',
        subBuilder: Media_Image.create)
    ..aOM<Media_Video>(
        2,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'video',
        subBuilder: Media_Video.create)
    ..aOM<Media_Audio>(
        3,
        const $core.bool.fromEnvironment('protobuf.omit_field_names')
            ? ''
            : 'audio',
        subBuilder: Media_Audio.create)
    ..hasRequiredFields = false;

  Media._() : super();
  factory Media({
    Media_Image? image,
    Media_Video? video,
    Media_Audio? audio,
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
    return _result;
  }
  factory Media.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Media.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Media clone() => Media()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Media copyWith(void Function(Media) updates) =>
      super.copyWith((message) => updates(message as Media))
          as Media; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Media create() => Media._();
  Media createEmptyInstance() => create();
  static $pb.PbList<Media> createRepeated() => $pb.PbList<Media>();
  @$core.pragma('dart2js:noInline')
  static Media getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Media>(create);
  static Media? _defaultInstance;

  Media_Kind whichKind() => _Media_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Media_Image get image => $_getN(0);
  @$pb.TagNumber(1)
  set image(Media_Image v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasImage() => $_has(0);
  @$pb.TagNumber(1)
  void clearImage() => clearField(1);
  @$pb.TagNumber(1)
  Media_Image ensureImage() => $_ensure(0);

  @$pb.TagNumber(2)
  Media_Video get video => $_getN(1);
  @$pb.TagNumber(2)
  set video(Media_Video v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVideo() => $_has(1);
  @$pb.TagNumber(2)
  void clearVideo() => clearField(2);
  @$pb.TagNumber(2)
  Media_Video ensureVideo() => $_ensure(1);

  @$pb.TagNumber(3)
  Media_Audio get audio => $_getN(2);
  @$pb.TagNumber(3)
  set audio(Media_Audio v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAudio() => $_has(2);
  @$pb.TagNumber(3)
  void clearAudio() => clearField(3);
  @$pb.TagNumber(3)
  Media_Audio ensureAudio() => $_ensure(2);
}
