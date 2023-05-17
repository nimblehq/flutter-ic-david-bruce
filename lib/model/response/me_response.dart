import 'package:json_annotation/json_annotation.dart';
import 'package:survey_flutter_ic/model/response/converter/response_converter.dart';
import 'package:survey_flutter_ic/model/user_model.dart';

part 'me_response.g.dart';

@JsonSerializable()
class MeResponse {
  final String email;
  final String avatarUrl;

  MeResponse({
    required this.email,
    required this.avatarUrl,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(mapDataJson(json));

  Map<String, dynamic> toJson() => _$MeResponseToJson(this);

  UserModel toModel() => UserModel(
        email: email,
        avatarUrl: avatarUrl,
      );
}
