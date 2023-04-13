import 'package:json_annotation/json_annotation.dart';

const String passwordGrantType = 'password';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'client_id')
  final String clientId;

  @JsonKey(name: 'client_secret')
  final String clientSecret;

  @JsonKey(name: 'grant_type')
  final String grantType;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  LoginRequest({
    required this.clientId,
    required this.clientSecret,
    required this.grantType,
    required this.email,
    required this.password,
  });
}
