import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/model/forgot_password_model.dart';
import 'package:survey_flutter_ic/model/response/converter/response_converter.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  final String message;

  ForgotPasswordResponse({
    required this.message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(mapDataJson(json));

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

  ForgotPasswordModel toModel() => ForgotPasswordModel(
        message: message,
      );
}
