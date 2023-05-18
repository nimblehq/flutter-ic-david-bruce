import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/ui/home/home_footer_component_id.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu_component_id.dart';
import 'package:survey_flutter_ic/ui/login/login_screen.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_screen.dart';
import 'package:survey_flutter_ic/utils/durations.dart';
import 'utils/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  homeTest();
}

void homeTest() {
  group('Home Screen', () {
    late Finder takeSurveyButton;
    late Finder logOutButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    testWidgets("When starting, it displays the Home screen correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/home',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();

      expect(find.text('Today'), findsOneWidget);
      takeSurveyButton = find.byKey(HomeFooterComponentId.takeSurveyButton);
      expect(takeSurveyButton, findsOneWidget);
    });

    testWidgets(
        "When tapping on take survey button, it shows survey details screen",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/home',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();

      await tester.tap(takeSurveyButton);
      await tester.pump(Durations.halfSecond);

      expect(find.byType(SurveyDetailsScreen), findsOneWidget);
    });

    testWidgets("When tapping on logout button, it shows login screen",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/home',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();

      final ScaffoldState state = tester.firstState(find.byType(Scaffold));
      state.openEndDrawer();
      await tester.pumpAndSettle(Durations.halfSecond);

      logOutButton = find.byKey(
        HomeSideMenuComponentId.logoutButton,
        skipOffstage: false,
      );
      expect(logOutButton, findsOneWidget);

      await tester.ensureVisible(logOutButton);
      await tester.tap(logOutButton);
      await tester.pumpAndSettle(Durations.oneSecond);

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
