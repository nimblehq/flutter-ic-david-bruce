import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:survey_flutter_ic/ui/home/home_screen.dart';
import 'package:survey_flutter_ic/ui/login/login_component_id.dart';
import 'package:survey_flutter_ic/ui/login/login_screen.dart';
import 'package:survey_flutter_ic/utils/durations.dart';
import 'utils/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  loginTest();
}

void loginTest() {
  group('Login Screen', () {
    late Finder emailTextField;
    late Finder passwordTextField;
    late Finder loginButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      emailTextField = find.byKey(LoginComponentId.emailTextField);
      passwordTextField = find.byKey(LoginComponentId.passwordTextField);
      loginButton = find.byKey(LoginComponentId.loginButton);
    });

    testWidgets("When starting, it displays the Login screen correctly",
        (WidgetTester tester) async {
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const LoginScreen()));
      await tester.pumpAndSettle();

      expect(emailTextField, findsOneWidget);
      expect(passwordTextField, findsOneWidget);
      expect(loginButton, findsOneWidget);
    });

    testWidgets(
        "When login with valid email or password, but the API returns failed",
        (WidgetTester tester) async {
      FakeData.updateResponse(
        keyLogin,
        const FakeResponseModel(400, {}),
      );
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const LoginScreen()));
      await tester.pumpAndSettle();
      await tester.enterText(emailTextField, 'test@email.com');
      await tester.enterText(passwordTextField, '12345678');
      await tester.tap(loginButton);
      await tester.pump(Durations.halfSecond);
      await tester.pumpAndSettle();

      expect(find.text('Please try again.'), findsOneWidget);
    });

    testWidgets(
        "When login with invalid email or password format, it returns error messages",
        (WidgetTester tester) async {
      FakeData.updateResponse(
        keyLogin,
        const FakeResponseModel(400, {}),
      );
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const LoginScreen()));
      await tester.pumpAndSettle();
      await tester.enterText(emailTextField, 'test@invalidemail');
      await tester.enterText(passwordTextField, '12345689');
      await tester.tap(loginButton);
      await tester.pump(Durations.halfSecond);
      await tester.pumpAndSettle();

      expect(find.text('Email is invalid, please check again'), findsOneWidget);
    });

    testWidgets(
        "When login with valid email or password, and the API returns successfully",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/login',
        isLogin: false,
      ));
      FakeData.initDefault();
      await tester.pumpAndSettle();
      await tester.pump(Durations.oneSecond);
      await tester.enterText(emailTextField, 'test@email.com');
      await tester.pump(Durations.oneSecond);
      await tester.enterText(passwordTextField, '12345678');
      await tester.pump(Durations.oneSecond);
      await tester.tap(loginButton);
      await tester.pump(Durations.halfSecond);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
