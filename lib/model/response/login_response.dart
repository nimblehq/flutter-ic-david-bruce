import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'token_type')
  final String tokenType;

  @JsonKey(name: 'expires_in')
  final double expiresIn;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'created_at')
  final double createdAt;

  LoginResponse({
    required this.id,
    required this.type,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });
}
