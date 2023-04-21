import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/model/request/forgot_password_user_request.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable()
class ForgotPasswordRequest {
  final ForgotPasswordUserRequest user;
  final String clientId;
  final String clientSecret;

  ForgotPasswordRequest({
    required this.user,
    required this.clientId,
    required this.clientSecret,
  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}
