import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/usecases/logout_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('LogoutUseCaseTest', () {
    late MockAuthRepository mockAuthRepository;
    late LogoutUseCase useCase;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      useCase = LogoutUseCase(mockAuthRepository);
    });

    test('Should call storage.clearAllStorage when logout', () async {
      await useCase.call();

      verify(mockAuthRepository.logout()).called(1);
    });
  });
}
