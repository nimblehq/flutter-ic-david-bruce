import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/forgot_password_use_case.dart';
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

    test(
        'should return success result with forgot password model on successful forgot password',
        () async {
      const message = '';
      when(mockAuthRepository.forgotPassword(
        email: email,
      )).thenAnswer((_) async => message);

      final result = await useCase.call(email);

      expect(result, isA<Success<String>>());
      expect((result as Success<String>).value, message);
      verify(mockAuthRepository.forgotPassword(email: email)).called(1);
    });

    test('should return failed result with error on failed forgot password',
        () async {
      when(mockAuthRepository.forgotPassword(
        email: email,
      )).thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(email);

      expect(result, isA<Failed<String>>());
      verify(mockAuthRepository.forgotPassword(email: email)).called(1);
    });
  });
}
