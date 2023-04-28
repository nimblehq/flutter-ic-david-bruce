import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/survey_meta_model.dart';

import 'converter/response_converter.dart';

part 'surveys_meta_response.g.dart';

@JsonSerializable()
class SurveysMetaResponse {
  final int? page;
  final int? pages;
  final int? pageSize;
  final int? records;

  SurveysMetaResponse({
    required this.page,
    required this.pages,
    required this.pageSize,
    required this.records,
  });

  factory SurveysMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveysMetaResponseFromJson(mapDataJson(json));

  SurveyMetaModel toSurveyMetaModel() => SurveyMetaModel(
        page: page ?? 0,
        pages: pages ?? 0,
        pageSize: pageSize ?? 0,
        records: records ?? 0,
      );
}
