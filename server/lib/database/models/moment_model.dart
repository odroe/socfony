import 'package:json_annotation/json_annotation.dart';

import '_helpers.dart';

part 'moment_model.g.dart';

@JsonSerializable(createToJson: false)
class MomentModel {
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  final String? title;
  final String? content;
  final List<String> images;

  @JsonKey(name: 'created_at', readValue: dateTimeReader)
  final DateTime createdAt;

  @JsonKey(name: 'likers_count')
  final int likersCount;

  @JsonKey(name: 'comments_count')
  final int commentsCount;

  const MomentModel({
    required this.id,
    required this.userId,
    this.title,
    this.content,
    this.images = const [],
    required this.createdAt,
    required this.likersCount,
    required this.commentsCount,
  });

  factory MomentModel.fromJson(Map<String, dynamic> json) =>
      _$MomentModelFromJson(json);
}
