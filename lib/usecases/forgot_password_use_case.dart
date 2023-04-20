import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:survey_flutter_ic/api/repository/auth_repository.dart';
import 'package:survey_flutter_ic/model/forgot_password_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/params/forgot_password_params.dart';

@Injectable()
class ForgotPasswordUseCase
    extends UseCase<ForgotPasswordModel, ForgotPasswordParams> {
  final AuthRepository _repository;

  const ForgotPasswordUseCase(this._repository);

  @override
  Future<Result<ForgotPasswordModel>> call(ForgotPasswordParams params) async {
    try {
      final result = await _repository.forgotPassword(email: params.user.email);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
