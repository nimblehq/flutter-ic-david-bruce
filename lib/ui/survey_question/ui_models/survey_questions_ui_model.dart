import 'package:equatable/equatable.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_question_ui_model.dart';

class SurveyQuestionsUIModel extends Equatable {
  final SurveyQuestionUIModel question;
  final SurveyAnswerUIModel answer;

  const SurveyQuestionsUIModel({
    required this.question,
    required this.answer,
  });

  @override
  List<Object?> get props => [
        question,
        answer,
      ];
}
