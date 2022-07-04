// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      bio: json['bio'] as String?,
      birthday: json['birthday'] as int?,
      registeredAt:
          DateTime.parse(dataTimeReader(json, 'registered_at') as String),
      gender: json['gender'] == null
          ? User_Gender.unknown
          : const _UserGenderConverter().fromJson(json['gender'] as String),
    );
