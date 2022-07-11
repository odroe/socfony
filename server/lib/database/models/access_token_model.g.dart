// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenModel _$AccessTokenModelFromJson(Map<String, dynamic> json) =>
    AccessTokenModel(
      json['token'] as String,
      ownerId: json['owner_id'] as String,
      createdAt: DateTime.parse(dateTimeReader(json, 'created_at') as String),
      expiredAt: DateTime.parse(dateTimeReader(json, 'expired_at') as String),
      refreshExpiredAt:
          DateTime.parse(dateTimeReader(json, 'refresh_expired_at') as String),
    );
