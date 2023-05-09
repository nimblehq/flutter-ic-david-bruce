import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/enum/emoticon_type.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/single_choice_view.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_screen.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/single_choice_option_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_ui_model.dart';

extension SurveyQuestionsScreenStateExtension on SurveyQuestionsScreenState {
  Widget buildAnswer(SurveyAnswerUIModel uiModel) {
    return _buildSingleChoice(uiModel.options);
    // switch (uiModel.displayType) {
    //   case DisplayType.dropdown:
    //     return _buildSingleChoice(uiModel.options);
    // case DisplayType.choice:
    //   return _buildMultipleChoice(uiModel.options);
    // case DisplayType.star:
    //   return _buildLikertScale(
    //     type: EmoticonType.star,
    //     options: uiModel.options,
    //   );
    // case DisplayType.heart:
    //   return _buildLikertScale(
    //     type: EmoticonType.heart,
    //     options: uiModel.options,
    //   );
    // case DisplayType.smiley:
    //   return _buildLikertScale(
    //     type: EmoticonType.smiley,
    //     options: uiModel.options,
    //   );
    // case DisplayType.nps:
    //   return _buildRatingScale(uiModel.options);
    // case DisplayType.textfield:
    //   return _buildFormWithTextField(uiModel.options);
    // case DisplayType.textarea:
    //   return _buildFormWithTextArea(uiModel.options.first);
    // case DisplayType.outro:
    //   return _buildOutro();
    // default:
    //   return Container();
    // }
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

  // Widget _buildMultipleChoice(List<OptionUiModel> options) {
  //   var sortedOptions = _sortByIndex(options);
  //   var uiModels = sortedOptions
  //       .map(
  //         (option) => MultipleChoiceOptionUIModel(
  //           id: option.id,
  //           title: option.title,
  //           isSelected: false,
  //         ),
  //       )
  //       .toList();
  //   return MultipleChoiceView(
  //     uiModels: uiModels,
  //     onSelect: (indexes) => _storeOptionAnswers(indexes),
  //   );
  // }

  // Widget _buildLikertScale({
  //   required LikertType type,
  //   required List<OptionUiModel> options,
  // }) {
  //   var sortedOptions = _sortByIndex(options);
  //   return LikertScaleView(
  //     type: type,
  //     onSelect: (index) => _storeOptionAnswers([sortedOptions[index].id]),
  //   );
  // }

  // Widget _buildRatingScale(List<OptionUiModel> options) {
  //   var sortedOptions = _sortByIndex(options);
  //   return RatingScaleView(
  //     onSelect: (index) => _storeOptionAnswers([sortedOptions[index].id]),
  //   );
  // }

  // Widget _buildFormWithTextField(List<OptionUiModel> options) {
  //   return FormWithTextFieldView(
  //     uiModels: options,
  //     onChange: _storeInputAnswers,
  //   );
  // }

  // Widget _buildFormWithTextArea(OptionUiModel uiModel) {
  //   return FormWithTextAreaView(
  //     uiModel: uiModel,
  //     onChange: _storeInputAnswers,
  //   );
  // }

  // Widget _buildOutro() {
  //   return const SizedBox.shrink();
  // }

  // void _storeOptionAnswers(List<String> ids) {
  //   ref.read(questionViewModelProvider.notifier).storeAnswerList(ids);
  // }

  // void _storeInputAnswers(Map<String, String> answers) {
  //   ref.read(questionViewModelProvider.notifier).storeAnswerMap(answers);
  // }

  List<SurveyAnswerOptionUIModel> _sortByIndex(
      List<SurveyAnswerOptionUIModel> options) {
    var sortedOptions = options;
    sortedOptions.sort((a, b) => (a.index.compareTo(b.index)));
    return sortedOptions;
  }
}
