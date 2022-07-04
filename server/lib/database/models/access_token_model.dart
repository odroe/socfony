import 'package:json_annotation/json_annotation.dart';

import '_helpers.dart';

part 'access_token_model.g.dart';

@JsonSerializable(createToJson: false)
class AccessTokenModel {
  final String token;

  @JsonKey(name: 'owner_id')
  final String ownerId;

  @JsonKey(name: 'created_at', readValue: dataTimeReader)
  final DateTime createdAt;

  @JsonKey(name: 'expired_at', readValue: dataTimeReader)
  final DateTime expiredAt;

  @JsonKey(name: 'refresh_expired_at', readValue: dataTimeReader)
  final DateTime refreshExpiredAt;

  const AccessTokenModel(
    this.token, {
    required this.ownerId,
    required this.createdAt,
    required this.expiredAt,
    required this.refreshExpiredAt,
  });

  factory AccessTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenModelFromJson(json);
}
