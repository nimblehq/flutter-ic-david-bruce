import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/model/response/login_response.dart';
import 'package:survey_flutter_ic/model/response/forgot_password_response.dart';
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

    test('When login is successful, it returns a LoginModel', () async {
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

    test('When login fails, it throws a NetworkExceptions', () async {
      when(mockAuthApiService.login(any)).thenThrow(Exception());

      final result = authRepository.login(email: email, password: password);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });

    test('When forgotPassword is successful, it returns a ForgotPasswordModel',
        () async {
      final forgotPasswordResponse = ForgotPasswordResponse(
        message: 'success',
      );
      when(mockAuthApiService.forgotPassword(any))
          .thenAnswer((_) async => forgotPasswordResponse);

      final result = await authRepository.forgotPassword(email: email);

      expect(result, forgotPasswordResponse.toModel());
      expect(result.message, equals(forgotPasswordResponse.message));
    });

    test('When forgotPassword fails, it throws a NetworkExceptions', () async {
      when(mockAuthApiService.forgotPassword(any)).thenThrow(Exception());

      final call = authRepository.forgotPassword(email: email);

      expect(call, throwsA(isA<NetworkExceptions>()));
    });
  });
}
