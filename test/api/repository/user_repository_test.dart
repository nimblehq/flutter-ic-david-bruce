import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter_ic/api/exception/network_exceptions.dart';
import 'package:survey_flutter_ic/api/repository/user_repository.dart';
import 'package:survey_flutter_ic/model/response/user_response.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SurveyRepositoryImplTest', () {
    late MockApiService mockApiService;
    late UserRepositoryImpl userRepository;

    setUp(() {
      mockApiService = MockApiService();
      userRepository = UserRepositoryImpl(mockApiService);
    });

    test('returns UserModel when getUserProfile successful', () async {
      final meResponse = UserResponse(email: 'email', avatarUrl: 'avatarUrl');

      when(mockApiService.getUserProfile()).thenAnswer((_) async => meResponse);

      final result = await userRepository.getUserProfile();

      expect(result, meResponse.toModel());
    });

    test('throws NetworkExceptions when getUserProfile unsuccessful', () async {
      when(mockApiService.getSurveyDetails(any)).thenThrow(Exception());

      try {
        await userRepository.getUserProfile();
      } catch (e) {
        expect(e, isInstanceOf<NetworkExceptions>());
      }
    });
  });
}
