import 'package:json_annotation/json_annotation.dart';

part 'phone_sent_code_model.g.dart';

@JsonSerializable(createToJson: false)
class PhoneSentCodeModel {
  final String phone;
  final String code;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'expired_at')
  final DateTime expiredAt;

  PhoneSentCodeModel({
    required this.phone,
    required this.code,
    required this.createdAt,
    required this.expiredAt,
  });

  factory PhoneSentCodeModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneSentCodeModelFromJson(json);
}
