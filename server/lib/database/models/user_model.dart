import 'package:json_annotation/json_annotation.dart';

import '_helpers.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel {
  final String id;
  final String phone;
  final String? name;
  final String? avatar;
  final String? bio;
  final int? birthday;

  @JsonKey(name: 'registered_at', readValue: dataTimeReader)
  final DateTime registeredAt;

  const UserModel({
    required this.id,
    required this.phone,
    this.name,
    this.avatar,
    this.bio,
    this.birthday,
    required this.registeredAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
