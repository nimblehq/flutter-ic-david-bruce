import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_user_request.g.dart';

@JsonSerializable()
class ForgotPasswordUserRequest {
  final String email;

  ForgotPasswordUserRequest({
    required this.email,
  });

  factory ForgotPasswordUserRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordUserRequestToJson(this);
}
