import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/model/user_model.dart';
import 'package:survey_flutter_ic/usecases/base/base_use_case.dart';
import 'package:survey_flutter_ic/usecases/get_user_profile_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetUserProfileUseCaseTest', () {
    late MockUserRepository mockUserRepository;
    late GetUserProfileUseCase useCase;
    const surveyId = '';

    setUp(() {
      mockUserRepository = MockUserRepository();
      useCase = GetUserProfileUseCase(mockUserRepository);
    });

    test('should return Success with UserModel when repository call succeeds',
        () async {
      when(mockUserRepository.getUserProfile())
          .thenAnswer((_) async => const UserModel.empty());

      final result = await useCase.call();

      expect(result, isA<Success<UserModel>>());
    });

    test(
        'should return Failed with UseCaseException when repository call fails',
        () async {
      when(mockUserRepository.getUserProfile())
          .thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call();

      expect(result, isA<Failed<UserModel>>());
    });
  });
}
