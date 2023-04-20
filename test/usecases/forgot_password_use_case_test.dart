import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/forgot_password_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/forgot_password_use_case.dart';
import 'package:survey_flutter_ic/usecases/params/forgot_password_params.dart';
import 'package:survey_flutter_ic/usecases/params/forgot_password_user_params.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('ForgotPasswordUseCaseTest', () {
    late MockAuthRepository mockAuthRepository;
    late ForgotPasswordUseCase useCase;

    const email = "email";

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      useCase = ForgotPasswordUseCase(mockAuthRepository);
    });

    test('When forgot password success, it returns success result', () async {
      const forgotPasswordModel = ForgotPasswordModel(message: '');
      when(mockAuthRepository.forgotPassword(
        email: email,
      )).thenAnswer((_) async => forgotPasswordModel);

      final result = await useCase.call(ForgotPasswordParams(
        user: ForgotPasswordUserParams(email: email),
      ));

      expect(result, isA<Success<ForgotPasswordModel>>());
    });

    test('When forgot password failed, it returns failed result', () async {
      when(mockAuthRepository.forgotPassword(
        email: email,
      )).thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(ForgotPasswordParams(
        user: ForgotPasswordUserParams(email: email),
      ));

      expect(result, isA<Failed<ForgotPasswordModel>>());
    });
  });
}
