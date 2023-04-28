import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/survey_meta_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';

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

  @override
  List<Object?> get props => [
        surveys,
        meta,
      ];
}
