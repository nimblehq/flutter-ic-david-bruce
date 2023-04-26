import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.init() = _Init;

  const factory ForgotPasswordState.loading() = _Loading;

  const factory ForgotPasswordState.success(String message) = _Success;

  const factory ForgotPasswordState.error(String errorMessage) = _Error;

  const factory ForgotPasswordState.errorEmailInput() = _ErrorEmailInput;
}
