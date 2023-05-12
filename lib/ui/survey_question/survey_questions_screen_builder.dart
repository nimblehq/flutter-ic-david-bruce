import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/enum/emoticon_type.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/emoticon_view.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/multiple_choice_view.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/point_rating_view.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/single_choice_view.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/text_field_form_view.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_screen.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/multiple_choice_option_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/single_choice_option_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_option_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_ui_model.dart';

extension SurveyQuestionsScreenStateExtension on SurveyQuestionsScreenState {
  Widget buildAnswer(SurveyAnswerUIModel uiModel) {
    switch (uiModel.displayType) {
      case DisplayType.dropdown:
        return _buildSingleChoice(uiModel.options);
      case DisplayType.choice:
        return _buildMultipleChoice(uiModel.options);
      case DisplayType.star:
        return _buildEmoticon(
          type: EmoticonType.star,
          options: uiModel.options,
        );
      case DisplayType.heart:
        return _buildEmoticon(
          type: EmoticonType.heart,
          options: uiModel.options,
        );
      case DisplayType.smiley:
        return _buildEmoticon(
          type: EmoticonType.smiley,
          options: uiModel.options,
        );
      case DisplayType.textfield:
        return _buildTextFieldForm(uiModel.options);
      case DisplayType.nps:
        return _buildPointRatingView();
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

  Widget _buildMultipleChoice(List<SurveyAnswerOptionUIModel> options) {
    var sortedOptions = _sortByIndex(options);
    var uiModels = sortedOptions
        .map(
          (option) => MultipleChoiceOptionUIModel(
            id: option.id,
            title: option.title,
            isSelected: false,
          ),
        )
        .toList();
    return MultipleChoiceView(
      uiModels: uiModels,
      onSelect: (indexes) => {},
    );
  }

  Widget _buildEmoticon({
    required EmoticonType type,
    required List<SurveyAnswerOptionUIModel> options,
  }) {
    return EmoticonView(
      type: type,
      onSelect: (index) => {},
    );
  }

  Widget _buildTextFieldForm(List<SurveyAnswerOptionUIModel> options) {
    return TextFieldFormView(
      uiModels: options,
      onChange: (_) => {},
    );
  }

  Widget _buildPointRatingView() {
    return PointRatingView(
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
