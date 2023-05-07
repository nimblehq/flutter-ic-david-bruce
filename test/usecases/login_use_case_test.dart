import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/login_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/login_use_case.dart';
import 'package:survey_flutter_ic/usecases/params/login_params.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginUseCaseTest', () {
    late MockAuthRepository mockAuthRepository;
    late MockStorage mockStorage;
    late LoginUseCase useCase;

    const email = "email";
    const password = "password";

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockStorage = MockStorage();
      useCase = LoginUseCase(mockAuthRepository, mockStorage);
    });

    test('When login success, it returns success result', () async {
      const loginModel = LoginModel(
        id: "1",
        accessToken: "2",
        expiresIn: 0,
        refreshToken: "3",
      );
      when(mockAuthRepository.login(
        email: email,
        password: password,
      )).thenAnswer((_) async => loginModel);

      final result = await useCase.call(LoginParams(
        email: email,
        password: password,
      ));

      expect(result, isA<Success<LoginModel>>());
      expect(
        verify(mockStorage.saveId(captureAny)).captured.single,
        '1',
      );
      expect(
        verify(mockStorage.saveAccessToken(captureAny)).captured.single,
        '2',
      );
      expect(
        verify(mockStorage.saveExpiresIn(captureAny)).captured.single,
        '0.0',
      );
      expect(
        verify(mockStorage.saveRefreshToken(captureAny)).captured.single,
        '3',
      );
    });

    test('When login failed, it returns failed result', () async {
      when(mockAuthRepository.login(
        email: email,
        password: password,
      )).thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(LoginParams(
        email: email,
        password: password,
      ));

      expect(result, isA<Failed<LoginModel>>());
    });
  });
}
