import 'package:survey_flutter_ic/usecases/params/forgot_password_user_params.dart';

class ForgotPasswordParams {
  final ForgotPasswordUserParams user;
  final String email;
  final String password;

  ForgotPasswordParams({
    required this.user,
    required this.email,
    required this.password,
  });
}
