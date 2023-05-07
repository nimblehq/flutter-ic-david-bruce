import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.init() = _Init;

  const factory LoginState.loading() = _Loading;

  const factory LoginState.success() = _Success;

  const factory LoginState.error(String errorMessage) = _Error;

  const factory LoginState.errorEmailInput() = _ErrorEmailInput;

  const factory LoginState.errorPasswordInput() = _ErrorPasswordInput;
}
