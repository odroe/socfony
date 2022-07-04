// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenModel _$AccessTokenModelFromJson(Map<String, dynamic> json) =>
    AccessTokenModel(
      json['token'] as String,
      ownerId: json['owner_id'] as String,
      createdAt: DateTime.parse(dataTimeReader(json, 'created_at') as String),
      expiredAt: DateTime.parse(dataTimeReader(json, 'expired_at') as String),
      refreshExpiredAt:
          DateTime.parse(dataTimeReader(json, 'refresh_expired_at') as String),
    );
