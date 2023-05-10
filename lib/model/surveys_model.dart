import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:survey_flutter_ic/model/survey_meta_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

part 'surveys_model.g.dart';

@JsonSerializable()
class SurveysModel extends Equatable {
  final List<SurveyModel> surveys;
  final SurveyMetaModel meta;

  const SurveysModel({
    required this.surveys,
    required this.meta,
  });

  SurveysModel.empty()
      : this(
          surveys: List.empty(),
          meta: const SurveyMetaModel.empty(),
        );

  static String serialize(SurveysModel response) {
    return jsonEncode(_$SurveysModelToJson(response));
  }

  static SurveysModel deserialize(String json) {
    return _$SurveysModelFromJson(jsonDecode(json));
  }

  @override
  List<Object?> get props => [
        surveys,
        meta,
      ];
}
