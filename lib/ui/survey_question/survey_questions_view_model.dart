import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_state.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_question_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_questions_ui_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_current_survey_use_case.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';

class SurveyQuestionsViewModel extends StateNotifier<SurveyQuestionsState> {
  final GetCurrentSurveyUseCase _getCurrentSurveyUseCase;

  String get _surveyIdValue => _surveyId ?? '';
  String? _surveyId;

  int get _questionNumberValue => _questionNumber ?? 0;
  int? _questionNumber;

  SurveyModel get _surveyValue => _survey ?? const SurveyModel.empty();
  SurveyModel? _survey;

  SurveyQuestionsUIModel get uiModel => _uiModel;
  SurveyQuestionsUIModel _uiModel = SurveyQuestionsUIModel(
    question: const SurveyQuestionUIModel.empty(),
    answer: SurveyAnswerUIModel.empty(),
  );

  SurveyQuestionsViewModel(
    this._getCurrentSurveyUseCase,
  ) : super(const SurveyQuestionsState.init());

  void setUpData({
    required Map<String, String> arguments,
  }) async {
    _surveyId = _setUpSurveyId(arguments);
    _questionNumber = _setUpQuestionNumber(arguments);
    _setUpSurveyDetailData().then((value) => _bindData());
  }

  Future<void> _setUpSurveyDetailData() async {
    final surveyResult = await _getCurrentSurveyUseCase.call();
    if (surveyResult is Success<SurveyModel?>) {
      _survey = surveyResult.value;
    }
  }

  void _bindData() {
    final totalQuestions = _surveyValue.questions.length;
    if (totalQuestions == 0 ||
        (totalQuestions == 1 &&
            _surveyValue.questions.first.displayType == DisplayType.intro)) {
      _bindEmptyData();
    } else {
      _bindDataWithoutIntro();
    }
  }

  void _bindDataWithoutIntro() {
    int totalQuestions = _surveyValue.questions.length;
    final questionIndex = _questionNumberValue + 1;
    if (_surveyValue.questions.first.displayType == DisplayType.intro) {
      totalQuestions--;
    }
    final questionsUiModel = SurveyQuestionUIModel(
      questionIndex: questionIndex,
      totalQuestions: totalQuestions,
      title: _surveyValue.questions[questionIndex].text,
    );
    final displayType = _surveyValue.questions[questionIndex].displayType;
    final options = _surveyValue.questions[questionIndex].answers
        .map(
          (answer) => SurveyAnswerOptionUIModel(
            index: answer.displayOrder,
            id: answer.id,
            title: answer.text,
          ),
        )
        .toList();
    final answerUiModel = SurveyAnswerUIModel(
      displayType: displayType,
      options: options,
    );
    _bindUIModelData(
      questionUiModel: questionsUiModel,
      answerUiModel: answerUiModel,
    );
  }

  void _bindEmptyData() {
    _bindUIModelData(
      questionUiModel: const SurveyQuestionUIModel.empty(),
      answerUiModel: SurveyAnswerUIModel.empty(),
    );
  }

  void _bindUIModelData({
    required SurveyQuestionUIModel questionUiModel,
    required SurveyAnswerUIModel answerUiModel,
  }) {
    final uiModel = SurveyQuestionsUIModel(
      question: questionUiModel,
      answer: answerUiModel,
    );
    _uiModel = uiModel;
    state = SurveyQuestionsState.success(uiModel: uiModel);
  }

  String _setUpSurveyId(Map<String, String> arguments) {
    return arguments[RoutePath.surveyQuestion.pathParam] ?? '';
  }

  int _setUpQuestionNumber(Map<String, String> arguments) {
    final questionNumber =
        arguments[RoutePath.surveyQuestion.queryParams.first] ?? '0';
    return int.parse(questionNumber);
  }

  Map<String, String> getPathParams() {
    var params = <String, String>{};
    params[RoutePath.surveyDetails.pathParam] = _surveyIdValue;
    return params;
  }

  Map<String, String> getNextQuestionQueryParams() {
    final nextQuestionNumber = _questionNumberValue + 1;
    var params = <String, String>{};
    params[RoutePath.surveyQuestion.queryParams.first] =
        nextQuestionNumber.toString();
    return params;
  }
}
