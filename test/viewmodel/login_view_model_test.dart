import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/model/login_model.dart';
import 'package:survey_flutter_ic/ui/login/login_screen.dart';
import 'package:survey_flutter_ic/ui/login/login_state.dart';
import 'package:survey_flutter_ic/ui/login/login_view_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Login view model test', () {
    late MockLoginUseCase mockLoginUseCase;
    late ProviderContainer container;

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      container = ProviderContainer(
        overrides: [
          loginViewModelProvider
              .overrideWith((ref) => LoginViewModel(mockLoginUseCase)),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing login view model, the login state is Init', () {
      expect(container.read(loginViewModelProvider), const LoginState.init());
    });

    test('When calling login returns successfully, it returns success state',
        () {
      const loginModel = LoginModel(
        id: "",
        accessToken: "",
        expiresIn: 0,
        refreshToken: "",
      );
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Success(loginModel));
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          const [
            LoginState.loading(),
            LoginState.success(),
          ],
        ),
      );
      container
          .read(loginViewModelProvider.notifier)
          .login('email@gmail.com', 'password');
    });

    test('When calling login return failed exception, it returns error state',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.unauthorisedRequest());
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            const LoginState.loading(),
            LoginState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.unauthorisedRequest(),
              ),
            ),
          ],
        ),
      );
      container
          .read(loginViewModelProvider.notifier)
          .login('email@gmail.com', 'password');
    });

    test('When calling login with invalid email, it returns email error state',
        () {
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder([const LoginState.errorEmailInput()]),
      );
      container
          .read(loginViewModelProvider.notifier)
          .login('email', 'password');
    });

    test(
        'When calling login with empty password, it returns password error state',
        () {
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder([const LoginState.errorPasswordInput()]),
      );
      container
          .read(loginViewModelProvider.notifier)
          .login('email@gmail.com', ' ');
    });
  });
}
