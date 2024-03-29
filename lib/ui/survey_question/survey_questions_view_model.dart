import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/model/survey_submission_answer_model.dart';
import 'package:survey_flutter_ic/model/survey_submission_model.dart';
import 'package:survey_flutter_ic/model/survey_submission_question_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_state.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_option_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_question_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_questions_ui_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_current_survey_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_survey_submission_use_case.dart';
import 'package:survey_flutter_ic/usecases/save_survey_submission_use_case.dart';
import 'package:survey_flutter_ic/usecases/submit_survey_answer_use_case.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';

import '../../api/exception/network_exceptions.dart';

class SurveyQuestionsViewModel extends StateNotifier<SurveyQuestionsState> {
  final GetCurrentSurveyUseCase _getCurrentSurveyUseCase;
  final GetSurveySubmissionUseCase _getSurveySubmissionUseCase;
  final SaveSurveySubmissionUseCase _saveSurveySubmissionUseCase;
  final SubmitSurveyAnswerUseCase _submitSurveyAnswerUseCase;

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

  List<String> _currentAnswerList = [];
  Map<String, String> _currentAnswerMap = <String, String>{};

  SurveyQuestionsViewModel(
    this._getCurrentSurveyUseCase,
    this._getSurveySubmissionUseCase,
    this._saveSurveySubmissionUseCase,
    this._submitSurveyAnswerUseCase,
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
            shortText: answer.questionShortText,
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
    state = SurveyQuestionsState.success(
      uiModel: uiModel,
      coverImageUrl: _survey?.coverImageUrl ?? '',
    );
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

  void storeAnswerList(List<String> ids) {
    _currentAnswerList = ids;
  }

  void storeAnswerMap(Map<String, String> answers) {
    _currentAnswerMap = answers;
  }

  void saveAnswer() {
    if (_currentAnswerList.isNotEmpty) {
      _saveAnswerList();
    }
    if (_currentAnswerMap.isNotEmpty) {
      _saveAnswerMap();
    }
  }

  void _saveAnswerList() async {
    final ids = _currentAnswerList;
    _storeAnswer(_idsToAnswers(ids));
  }

  void _saveAnswerMap() async {
    final answerMap = _currentAnswerMap;
    _storeAnswer(_answerMapToAnswers(answerMap));
  }

  void _storeAnswer(List<SurveySubmissionAnswerModel> answers) async {
    final result = await _getSurveySubmissionUseCase.call();
    if (result is Success<SurveySubmissionModel?>) {
      var submission = result.value;
      if (submission == null) {
        submission = _newSurveySubmission(answers);
      } else if (submission.surveyId != _surveyIdValue ||
          _questionNumberValue == 0) {
        await _clearStoredCurrentSurveySubmission();
        submission = _newSurveySubmission(answers);
      } else {
        submission = _addNewAnswerToSurveySubmission(
          submission,
          answers,
        );
      }
      await _saveSurveySubmissionUseCase.call(submission);
    }
  }

  SurveySubmissionModel _newSurveySubmission(
    List<SurveySubmissionAnswerModel> answers,
  ) {
    return SurveySubmissionModel(
      surveyId: _surveyIdValue,
      questions: [
        SurveySubmissionQuestionModel(
          id: _surveyValue.questions[_questionNumberValue].id,
          answers: answers,
        ),
      ],
    );
  }

  SurveySubmissionModel _addNewAnswerToSurveySubmission(
    SurveySubmissionModel submission,
    List<SurveySubmissionAnswerModel> answers,
  ) {
    List<SurveySubmissionQuestionModel> questions = submission.questions;
    questions.add(
      SurveySubmissionQuestionModel(
        id: _surveyValue.questions[_questionNumberValue].id,
        answers: answers,
      ),
    );
    submission.questions = questions;
    return submission;
  }

  List<SurveySubmissionAnswerModel> _idsToAnswers(List<String> ids) {
    return ids
        .map(
          (id) => SurveySubmissionAnswerModel(
            id: id,
            answer: null,
          ),
        )
        .toList();
  }

  List<SurveySubmissionAnswerModel> _answerMapToAnswers(
      Map<String, String> answerMap) {
    List<SurveySubmissionAnswerModel> answers = [];
    answerMap.forEach(
      (key, value) {
        answers.add(
          SurveySubmissionAnswerModel(
            id: key,
            answer: value,
          ),
        );
      },
    );
    return answers;
  }

  void submitAnswers() async {
    final result = await _getSurveySubmissionUseCase.call();
    if (result is Success<SurveySubmissionModel?>) {
      state = SurveyQuestionsState.submitting(
        uiModel: uiModel,
        coverImageUrl: _survey?.coverImageUrl ?? '',
      );
      final submission = result.value;
      if (submission != null) {
        final result = await _submitSurveyAnswerUseCase.call(submission);
        if (result is Success<bool>) {
          state = SurveyQuestionsState.submitted(
            uiModel: uiModel,
            coverImageUrl: _survey?.coverImageUrl ?? '',
          );
          await _clearStoredCurrentSurveySubmission();
        } else {
          state = SurveyQuestionsState.error(
            uiModel: uiModel,
            coverImageUrl: _survey?.coverImageUrl ?? '',
            error: NetworkExceptions.getErrorMessage(
              (result as Failed).exception.actualException,
            ),
          );
        }
      }
    }
  }

  Future<void> _clearStoredCurrentSurveySubmission() async {
    await _saveSurveySubmissionUseCase.call(null);
  }
}
