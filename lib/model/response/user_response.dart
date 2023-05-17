import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/model/response/converter/response_converter.dart';
import 'package:survey_flutter_ic/model/user_model.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String email;
  final String avatarUrl;

  UserResponse({
    required this.email,
    required this.avatarUrl,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(mapDataJson(json));

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserModel toModel() => UserModel(
        email: email,
        avatarUrl: avatarUrl,
      );
}
