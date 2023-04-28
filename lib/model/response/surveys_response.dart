import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/response/converter/response_converter.dart';
import 'package:survey_flutter_ic/model/response/survey_response.dart';
import 'package:survey_flutter_ic/model/response/surveys_meta_response.dart';
import 'package:survey_flutter_ic/model/survey_meta_model.dart';
import 'package:survey_flutter_ic/model/surveys_model.dart';

part 'surveys_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  final List<SurveyResponse>? data;
  final SurveysMetaResponse? meta;

  const SurveysResponse({
    required this.data,
    required this.meta,
  });

  factory SurveysResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveysResponseFromJson(mapRootJson(json));
  }

  SurveysModel toSurveysModel() => SurveysModel(
        surveys:
            data?.map((item) => item.toSurveyModel()).toList() ?? List.empty(),
        meta: meta?.toSurveyMetaModel() ?? const SurveyMetaModel.empty(),
      );
}
