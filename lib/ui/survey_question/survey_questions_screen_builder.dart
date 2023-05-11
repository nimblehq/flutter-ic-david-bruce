import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/single_choice_view.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_screen.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/single_choice_option_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_ui_model.dart';

extension SurveyQuestionsScreenStateExtension on SurveyQuestionsScreenState {
  Widget buildAnswer(SurveyAnswerUIModel uiModel) {
    switch (uiModel.displayType) {
      case DisplayType.dropdown:
        return _buildSingleChoice(uiModel.options);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildSingleChoice(List<SurveyAnswerOptionUIModel> options) {
    var sortedOptions = _sortByIndex(options);
    var uiModels = sortedOptions
        .map(
          (option) => SingleChoiceOptionUIModel(
            id: option.id,
            title: option.title,
            isSelected: false,
          ),
        )
        .toList();
    return SingleChoiceView(
      uiModels: uiModels,
      onSelect: (index) => {},
    );
  }

  List<SurveyAnswerOptionUIModel> _sortByIndex(
      List<SurveyAnswerOptionUIModel> options) {
    var sortedOptions = options;
    sortedOptions.sort((a, b) => (a.index.compareTo(b.index)));
    return sortedOptions;
  }
}
