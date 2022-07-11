// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentModel _$MomentModelFromJson(Map<String, dynamic> json) => MomentModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String?,
      content: json['content'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(dateTimeReader(json, 'created_at') as String),
      likersCount: json['likers_count'] as int,
      commentsCount: json['comments_count'] as int,
    );
