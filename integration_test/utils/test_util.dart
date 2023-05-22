import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/api/repository/survey_repository.dart';
import 'package:survey_flutter_ic/api/repository/user_repository.dart';
import 'package:survey_flutter_ic/api/storage/storage.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/main.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:survey_flutter_ic/utils/app_route.dart';

import '../fake_services/fake_api_service.dart';
import '../fake_services/fake_auth_api_service.dart';

GoRouter? _router;

class TestUtil {
  /// This is useful when we test the whole app with the real configs(styling,
  /// localization, routes, etc)
  static Widget pumpWidgetWithRealApp(String initialRoute) {
    _initDependencies();
    return const MyApp();
  }

  /// We normally use this function to test a specific [widget] without
  /// considering much about theming.
  static Widget pumpWidgetWithShellApp(Widget widget) {
    _initDependencies();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ProviderScope(child: widget),
    );
  }

  static Widget pumpWidgetWithShellAppGoRouter({
    required String location,
    required bool isLogin,
  }) {
    _initDependencies();
    _setUpSecureStorage(isLogin);
    _router = getIt.get<AppRouter>().router(location);
    return ProviderScope(
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routeInformationProvider: _router?.routeInformationProvider,
        routeInformationParser: _router?.routeInformationParser,
        routerDelegate: _router?.routerDelegate,
      ),
    );
  }

  static void _initDependencies() {
    PackageInfo.setMockInitialValues(
      appName: 'Flutter templates testing',
      packageName: '',
      version: '',
      buildNumber: '',
      buildSignature: '',
    );
    FlutterConfig.loadValueForTesting({
      'REST_API_ENDPOINT': 'REST_API_ENDPOINT',
      'CLIENT_ID': 'CLIENT_ID',
      'CLIENT_SECRET': 'CLIENT_SECRET',
    });
  }

  static void _setUpSecureStorage(bool isLogin) {
    final secureStorage = getIt.get<Storage>();
    if (isLogin) {
      secureStorage.saveId('id');
      secureStorage.saveTokenType('token_type');
      secureStorage.saveAccessToken('access_token');
      secureStorage.saveExpiresIn('-1');
      secureStorage.saveRefreshToken('refresh_token');
    } else {
      secureStorage.clearAllStorage();
    }
  }

  static Future setupTestEnvironment() async {
    _initDependencies();
    await configureDependencies();
    getIt.allowReassignment = true;
    getIt.registerSingleton<AuthRepository>(
        AuthRepositoryImpl(FakeAuthApiService(), getIt.get<Storage>()));
    getIt.registerSingleton<SurveyRepository>(
        SurveyRepositoryImpl(FakeApiService(), getIt.get<Storage>()));
    getIt.registerSingleton<UserRepository>(
        UserRepositoryImpl(FakeApiService()));
  }
}
