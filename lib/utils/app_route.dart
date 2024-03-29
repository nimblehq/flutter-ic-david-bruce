import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_screen.dart';
import 'package:survey_flutter_ic/ui/home/home_screen.dart';
import 'package:survey_flutter_ic/ui/login/login_screen.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_screen.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_screen.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';

@Singleton()
class AppRouter {
  final Storage _storage;

  AppRouter(this._storage);

  GoRouter router(String? initialLocation) => GoRouter(
        initialLocation: initialLocation ?? RoutePath.home.path,
        routes: <GoRoute>[
          GoRoute(
            path: RoutePath.home.screen,
            name: RoutePath.home.name,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: RoutePath.surveyDetails.screenWithPathParams,
                name: RoutePath.surveyDetails.name,
                builder: (context, state) => SurveyDetailsScreen(
                    surveyId:
                        state.params[RoutePath.surveyDetails.pathParam] ?? ''),
              ),
              GoRoute(
                path: RoutePath.surveyQuestion.screenWithPathParams,
                name: RoutePath.surveyQuestion.name,
                builder: (context, state) => SurveyQuestionsScreen(
                  surveyId:
                      state.params[RoutePath.surveyQuestion.pathParam] ?? '',
                  questionNumber: int.parse(state
                          .params[RoutePath.surveyQuestion.queryParams.first] ??
                      0.toString()),
                ),
              ),
            ],
          ),
          GoRoute(
            path: RoutePath.login.screen,
            name: RoutePath.login.name,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: RoutePath.forgotPassword.screen,
            name: RoutePath.forgotPassword.name,
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
        ],
        redirect: (context, state) async {
          final subLocation = state.subloc;
          final isLogin = await _storage.id != null;
          if (!isLogin &&
              subLocation != RoutePath.forgotPassword.path &&
              subLocation != RoutePath.login.path) {
            return RoutePath.login.path;
          }
          return null;
        },
        errorBuilder: (context, state) {
          _storage.clearAllStorage();
          return const LoginScreen();
        },
      );
}
