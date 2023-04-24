import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/model/response/forgot_password_meta_response.dart';
import 'package:survey_flutter_ic/model/response/converter/response_converter.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  final ForgotPasswordMetaResponse meta;

  ForgotPasswordResponse({
    required this.meta,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(mapDataJson(json));
}
