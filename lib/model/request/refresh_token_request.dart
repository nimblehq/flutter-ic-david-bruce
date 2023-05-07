import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request.g.dart';

@JsonSerializable()
class RefreshTokenRequest {
  static const String refreshTokenGrantType = 'refresh_token';

  final String refreshToken;
  final String clientId;
  final String clientSecret;
  final String grantType;

  RefreshTokenRequest({
    required this.refreshToken,
    required this.clientId,
    required this.clientSecret,
    required this.grantType,
  });

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
