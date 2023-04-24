import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_state.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/forgot_password_use_case.dart';
import 'package:survey_flutter_ic/utils/string_ext.dart';

class ForgotPasswordViewModel extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordViewModel(this._forgotPasswordUseCase)
      : super(const ForgotPasswordState.init());

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  void forgotPassword(String email) async {
    if (!email.validateEmail()) {
      state = const ForgotPasswordState.errorEmailInput();
    } else {
      state = const ForgotPasswordState.loading();
      Result<void> result = await _forgotPasswordUseCase.call(email);
      if (result is Success) {
        state = ForgotPasswordState.success(result.value);
      } else {
        state = ForgotPasswordState.error(
          NetworkExceptions.getErrorMessage(
              (result as Failed).exception.actualException),
        );
      }
    }
  }
}
