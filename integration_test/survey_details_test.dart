import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_component_id.dart';

import 'utils/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  surveyDetailsTest();
}

void surveyDetailsTest() {
  group('Integration test with survey details screen', () {
    late Finder startSurveyButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    testWidgets(
        "When launching, it displays the survey details screen correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/survey-details/111',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();

      startSurveyButton = find.byKey(
        SurveyDetailsComponentId.startSurveyButton,
      );

      expect(startSurveyButton, findsOneWidget);
    });
  });
}
