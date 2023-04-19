import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/model/response/login_response.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'CLIENT_ID': 'CLIENT_ID',
    'CLIENT_SECRET': 'CLIENT_SECRET',
  });

  group('AuthApiRepositoryImplTest', () {
    late MockAuthApiService mockAuthApiService;
    late AuthRepositoryImpl authRepository;

    const email = "email";
    const password = "password";

    setUp(() {
      mockAuthApiService = MockAuthApiService();
      authRepository = AuthRepositoryImpl(mockAuthApiService);
    });

    test('When login successfully, it returns success model', () async {
      final loginResponse = LoginResponse(
        id: "",
        type: "",
        accessToken: "",
        tokenType: "",
        expiresIn: 0,
        refreshToken: "",
        createdAt: 0,
      );

      when(mockAuthApiService.login(any))
          .thenAnswer((_) async => loginResponse);

      final result =
          await authRepository.login(email: email, password: password);

      expect(result, loginResponse.toModel());
    });

    test('When login unsuccessfully, it returns failed exception', () async {
      when(mockAuthApiService.login(any)).thenThrow(Exception());

      final result = authRepository.login(email: email, password: password);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
