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
    late LoginUseCase useCase;

    const email = "email";
    const password = "password";

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      useCase = LoginUseCase(mockAuthRepository);
    });

    test('When login success, it returns success result', () async {
      const loginModel = LoginModel(
        id: "",
        accessToken: "",
        expiresIn: 0,
        refreshToken: "",
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
