import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_component_id.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_answer_views/survey_answer_component_id.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_question_component_id.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_screen.dart';
import 'package:survey_flutter_ic/ui/widgets/lottie_dialog.dart';
import 'package:survey_flutter_ic/utils/durations.dart';

import 'utils/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  surveyQuestionsTest();
}

void surveyQuestionsTest() {
  group('Integration test with survey questions screen', () {
    late Finder nextButton;
    late Finder submitButton;
    late Finder answerView;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    testWidgets(
        "When launching, it displays the survey questions screen correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/survey-details/d5de6a8f8f5f1cfe51bc',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();
      final startSurveyButton =
          find.byKey(SurveyDetailsComponentId.startSurveyButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(find.byType(SurveyQuestionsScreen), findsOneWidget);
      nextButton = find.byKey(SurveyQuestionComponentId.nextButton);
      expect(nextButton, findsOneWidget);

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      submitButton = find.byKey(SurveyQuestionComponentId.submitButton);
      expect(submitButton, findsOneWidget);
    });

    testWidgets(
        "When user press submit answers successfully, it returns to home screen",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/survey-details/d5de6a8f8f5f1cfe51bc',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();
      final startSurveyButton =
          find.byKey(SurveyDetailsComponentId.startSurveyButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      answerView = find.byKey(AnswerComponentId.answer('1'));
      await tester.tap(answerView);
      await tester.pumpAndSettle();

      nextButton = find.byKey(SurveyQuestionComponentId.nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      submitButton = find.byKey(SurveyQuestionComponentId.submitButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      await tester.pump(Durations.fiveSecond);

      expect(find.byType(LottieDialog), findsOneWidget);
    });
  });
}
