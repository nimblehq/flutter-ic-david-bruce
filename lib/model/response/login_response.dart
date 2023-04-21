import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/model/login_model.dart';
import 'package:survey_flutter_ic/model/response/converter/response_converter.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String id;
  final String type;
  final String accessToken;
  final String tokenType;
  final double expiresIn;
  final String refreshToken;
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

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(mapDataJson(json));

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  LoginModel toModel() => LoginModel(
        id: id,
        accessToken: accessToken,
        expiresIn: expiresIn,
        refreshToken: refreshToken,
      );
}
