import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_screen.dart';
import 'package:survey_flutter_ic/ui/login/login_screen.dart';
import 'package:survey_flutter_ic/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await configureDependencies();
  runApp(MyApp());
}

const routePathRootScreen = '/';
const routePathForgotPasswordScreen = 'forgotPasword';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: routePathRootScreen,
        builder: (_, __) => const LoginScreen(),
        routes: [
          GoRoute(
            path: routePathForgotPasswordScreen,
            builder: (_, __) => const ForgotPasswordScreen(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: Assets.fonts.neuzeit,
        appBarTheme: Themes.appBarTheme,
        textTheme: Themes.textTheme,
        buttonTheme: Themes.buttonTheme,
        elevatedButtonTheme: Themes.elevatedButtonThemeData,
        textButtonTheme: Themes.textButtonThemeData,
        inputDecorationTheme: Themes.inputDecorationTheme,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
