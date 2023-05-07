import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  static const String passwordGrantType = 'password';

  final String clientId;
  final String clientSecret;
  final String grantType;
  final String email;
  final String password;

  LoginRequest({
    required this.clientId,
    required this.clientSecret,
    required this.grantType,
    required this.email,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
