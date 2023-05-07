import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/ui/login/login_state.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/login_use_case.dart';
import 'package:survey_flutter_ic/usecases/params/login_params.dart';
import 'package:survey_flutter_ic/utils/string_ext.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel(this._loginUseCase) : super(const LoginState.init());

  final LoginUseCase _loginUseCase;

  void login(String email, String password) async {
    state = const LoginState.loading();
    if (!email.validateEmail()) {
      state = const LoginState.errorEmailInput();
    } else if (!password.validatePassword()) {
      state = const LoginState.errorPasswordInput();
    } else {
      Result<void> result = await _loginUseCase.call(
        LoginParams(
          email: email,
          password: password,
        ),
      );
      if (result is Success) {
        state = const LoginState.success();
      } else {
        state = LoginState.error(
          NetworkExceptions.getErrorMessage(
              (result as Failed).exception.actualException),
        );
      }
    }
  }
}
