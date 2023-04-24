import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/model/response/converter/response_converter.dart';

part 'forgot_password_meta_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ForgotPasswordMetaResponse {
  final String message;

  ForgotPasswordMetaResponse({
    required this.message,
  });

  factory ForgotPasswordMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordMetaResponseFromJson(mapDataJson(json));
}
