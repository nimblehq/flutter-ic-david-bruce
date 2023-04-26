import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_screen.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_state.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_view_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Forgot password view model test', () {
    late MockForgotPasswordUseCase mockForgotPasswordUseCase;
    late ProviderContainer container;

    setUp(() {
      mockForgotPasswordUseCase = MockForgotPasswordUseCase();
      container = ProviderContainer(
        overrides: [
          forgotPasswordViewModelProvider.overrideWith(
              (ref) => ForgotPasswordViewModel(mockForgotPasswordUseCase)),
        ],
      );
      addTearDown(container.dispose);
    });

    test(
        'When initializing forgot password view model, the forgot password state is Init',
        () {
      expect(container.read(forgotPasswordViewModelProvider),
          const ForgotPasswordState.init());
    });

    test(
        'When calling forgotPassword returns successfully, it returns success state',
        () {
      const message = '';
      when(mockForgotPasswordUseCase.call(any))
          .thenAnswer((_) async => Success(message));
      final stateStream =
          container.read(forgotPasswordViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          const [
            ForgotPasswordState.loading(),
            ForgotPasswordState.success(message),
          ],
        ),
      );
      container
          .read(forgotPasswordViewModelProvider.notifier)
          .forgotPassword('email@gmail.com');
    });

    test(
        'When calling forgotPassword return failed exception, it returns error state',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.unauthorisedRequest());
      when(mockForgotPasswordUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(forgotPasswordViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            const ForgotPasswordState.loading(),
            ForgotPasswordState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.unauthorisedRequest(),
              ),
            ),
          ],
        ),
      );
      container
          .read(forgotPasswordViewModelProvider.notifier)
          .forgotPassword('email@gmail.com');
    });

    test(
        'When calling forgotPassword with invalid email, it returns email error state',
        () {
      final stateStream =
          container.read(forgotPasswordViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder([
          const ForgotPasswordState.loading(),
          const ForgotPasswordState.errorEmailInput()
        ]),
      );
      container
          .read(forgotPasswordViewModelProvider.notifier)
          .forgotPassword('email');
    });
  });
}
