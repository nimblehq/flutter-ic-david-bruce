import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/enum/display_type.dart';
import 'package:survey_flutter_ic/model/survey_answer_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/model/survey_question_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_screen.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_state.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_view_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_option_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_answer_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_question_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_questions_ui_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Survey questions view model test', () {
    late MockGetCurrentSurveyUseCase mockGetCurrentSurveyUseCase;
    late ProviderContainer container;

    setUp(() {
      mockGetCurrentSurveyUseCase = MockGetCurrentSurveyUseCase();
      container = ProviderContainer(
        overrides: [
          surveyQuestionsViewModelProvider
              .overrideWith((ref) => SurveyQuestionsViewModel(
                    mockGetCurrentSurveyUseCase,
                  )),
        ],
      );
      addTearDown(container.dispose);
    });

    test('should initialize with initial state', () {
      expect(container.read(surveyQuestionsViewModelProvider),
          const SurveyQuestionsState.init());
    });

    test('should bind empty data when survey has no questions', () {
      when(mockGetCurrentSurveyUseCase.call())
          .thenAnswer((_) async => Success(const SurveyModel.empty()));
      final stateStream =
          container.read(surveyQuestionsViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            SurveyQuestionsState.success(
              uiModel: SurveyQuestionsUIModel(
                question: const SurveyQuestionUIModel.empty(),
                answer: SurveyAnswerUIModel.empty(),
              ),
              coverImageUrl: '',
            ),
          ],
        ),
      );
      container
          .read(surveyQuestionsViewModelProvider.notifier)
          .setUpData(arguments: {
        'surveyId': '123',
        'questionNumber': '1',
      });
    });

    test('should bind data when survey has questions and intro', () {
      when(mockGetCurrentSurveyUseCase.call()).thenAnswer((_) async =>
          Success(const SurveyModel(
            id: '123',
            title: 'title',
            description: 'description',
            thankEmailAboveThreshold: 'thankEmailAboveThreshold',
            thankEmailBelowThreshold: 'thankEmailBelowThreshold',
            isActive: true,
            coverImageUrl: 'coverImageUrl',
            createdAt: 'createdAt',
            activeAt: 'activeAt',
            inactiveAt: 'inactiveAt',
            surveyType: 'surveyType',
            questions: [
              SurveyQuestionModel(
                id: 'id0',
                text: 'text0',
                displayOrder: 0,
                imageUrl: 'imageUrl0',
                coverImageUrl: 'coverImageUrl0',
                displayType: DisplayType.intro,
                answers: [],
              ),
              SurveyQuestionModel(
                id: 'id1',
                text: 'text1',
                displayOrder: 1,
                imageUrl: 'imageUrl1',
                coverImageUrl: 'coverImageUrl1',
                displayType: DisplayType.star,
                answers: [
                  SurveyAnswerModel(id: 'id-star0', text: '0', displayOrder: 0),
                  SurveyAnswerModel(id: 'id-star1', text: '1', displayOrder: 1),
                  SurveyAnswerModel(id: 'id-star2', text: '2', displayOrder: 2),
                  SurveyAnswerModel(id: 'id-star3', text: '3', displayOrder: 3),
                  SurveyAnswerModel(id: 'id-star4', text: '4', displayOrder: 4),
                ],
              ),
              SurveyQuestionModel(
                id: 'id2',
                text: 'text2',
                displayOrder: 2,
                imageUrl: 'imageUrl2',
                coverImageUrl: 'coverImageUrl2',
                displayType: DisplayType.outro,
                answers: [],
              ),
            ],
          )));
      final stateStream =
          container.read(surveyQuestionsViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            const SurveyQuestionsState.success(
              uiModel: SurveyQuestionsUIModel(
                question: SurveyQuestionUIModel(
                  questionIndex: 1,
                  totalQuestions: 2,
                  title: 'text1',
                ),
                answer: SurveyAnswerUIModel(
                  displayType: DisplayType.star,
                  options: [
                    SurveyAnswerOptionUIModel(
                        index: 0, id: 'id-star0', title: '0'),
                    SurveyAnswerOptionUIModel(
                        index: 1, id: 'id-star1', title: '1'),
                    SurveyAnswerOptionUIModel(
                        index: 2, id: 'id-star2', title: '2'),
                    SurveyAnswerOptionUIModel(
                        index: 3, id: 'id-star3', title: '3'),
                    SurveyAnswerOptionUIModel(
                        index: 4, id: 'id-star4', title: '4'),
                  ],
                ),
              ),
              coverImageUrl: 'coverImageUrl',
            ),
          ],
        ),
      );
      container
          .read(surveyQuestionsViewModelProvider.notifier)
          .setUpData(arguments: {
        'surveyId': '123',
        'questionNumber': '0',
      });
    });

    test('getPathParams returns the correct path params', () {
      when(mockGetCurrentSurveyUseCase.call())
          .thenAnswer((_) async => Success(const SurveyModel.empty()));
      container
          .read(surveyQuestionsViewModelProvider.notifier)
          .setUpData(arguments: {
        'surveyId': '123',
        'questionNumber': '1',
      });
      final result = container
          .read(surveyQuestionsViewModelProvider.notifier)
          .getPathParams();

      expect(result, {'surveyId': '123'});
    });

    test('getNextQuestionQueryParams returns the correct query params', () {
      when(mockGetCurrentSurveyUseCase.call())
          .thenAnswer((_) async => Success(const SurveyModel.empty()));
      container
          .read(surveyQuestionsViewModelProvider.notifier)
          .setUpData(arguments: {
        'surveyId': '123',
        'questionNumber': '1',
      });
      when(mockGetCurrentSurveyUseCase.call())
          .thenAnswer((_) async => Success(const SurveyModel.empty()));
      container
          .read(surveyQuestionsViewModelProvider.notifier)
          .setUpData(arguments: {
        'surveyId': '123',
        'questionNumber': '1',
      });
      final result = container
          .read(surveyQuestionsViewModelProvider.notifier)
          .getNextQuestionQueryParams();

      expect(result, {'questionNumber': '2'});
    });
  });
}
