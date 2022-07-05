import 'package:json_annotation/json_annotation.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '_helpers.dart';

part 'user_model.g.dart';

class _UserGenderConverter extends JsonConverter<User_Gender, String> {
  const _UserGenderConverter();

  @override
  User_Gender fromJson(String json) {
    for (final User_Gender gender in User_Gender.values) {
      if (gender.name.toLowerCase() == json.toLowerCase()) return gender;
    }

    return User_Gender.unknown;
  }

  @override
  String toJson(User_Gender object) => object.name;
}

@JsonSerializable(createToJson: false)
class UserModel {
  final String id;
  final String phone;
  final String? name;
  final String? avatar;
  final String? bio;
  final int? birthday;

  @_UserGenderConverter()
  final User_Gender gender;

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
    this.gender = User_Gender.unknown,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// To gRPC message. -> User
  User toGrpcMessage() => User(
        id: id,
        name: name,
        avatar: avatar,
        bio: bio,
        birthday: birthday,
        gender: gender,
        phone: phone,
      );
}
