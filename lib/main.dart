import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_screen.dart';
import 'package:survey_flutter_ic/ui/home/home_screen.dart';
import 'package:survey_flutter_ic/ui/login/login_screen.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';
import 'package:survey_flutter_ic/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await configureDependencies();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: RoutePath.login.path,
        builder: (_, __) => const LoginScreen(),
        routes: [
          GoRoute(
            path: RoutePath.forgotPassword.path,
            name: RoutePath.forgotPassword.name,
            builder: (_, __) => const ForgotPasswordScreen(),
          ),
          GoRoute(
            path: RoutePath.home.path,
            name: RoutePath.home.name,
            builder: (_, __) => const HomeScreen(),
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
