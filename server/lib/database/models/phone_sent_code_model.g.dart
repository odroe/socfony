// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_sent_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneSentCodeModel _$PhoneSentCodeModelFromJson(Map<String, dynamic> json) =>
    PhoneSentCodeModel(
      phone: json['phone'] as String,
      code: json['code'] as String,
      createdAt: DateTime.parse(dataTimeReader(json, 'created_at') as String),
      expiredAt: DateTime.parse(dataTimeReader(json, 'expired_at') as String),
    );