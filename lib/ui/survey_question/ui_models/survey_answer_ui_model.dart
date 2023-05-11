import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_option_ui_model.dart';

class SurveyAnswerUIModel extends Equatable {
  final DisplayType displayType;
  final List<SurveyAnswerOptionUIModel> options;

  const SurveyAnswerUIModel({
    required this.displayType,
    required this.options,
  });

  SurveyAnswerUIModel.empty()
      : this(
          displayType: DisplayType.unknown,
          options: [],
        );

  @override
  List<Object?> get props => [
        displayType,
        options,
      ];
}
