import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter_ic/api/service/api_service.dart';
import 'package:survey_flutter_ic/model/response/survey_response.dart';
import 'package:survey_flutter_ic/model/response/surveys_response.dart';
import 'package:survey_flutter_ic/model/response/user_response.dart';
import '../utils/fake_data.dart';

const Duration fakeApiDuration = Duration(milliseconds: 50);

class FakeApiService extends Fake implements ApiService {
  @override
  Future<UserResponse> getUserProfile() async {
    await Future.delayed(fakeApiDuration);
    final response = FakeData.apiAndResponse[keyMyProfile]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return UserResponse.fromJson(response.json);
  }

  @override
  Future<SurveysResponse> getSurveys(
    int pageNumber,
    int pageSize,
  ) async {
    await Future.delayed(fakeApiDuration);
    final response = FakeData.apiAndResponse[keySurveys]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return SurveysResponse.fromJson(response.json);
  }

  @override
  Future<SurveyResponse> getSurveyDetails(
    String id,
  ) async {
    await Future.delayed(fakeApiDuration);
    final response = FakeData.apiAndResponse[keySurveyDetail]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return SurveyResponse.fromJson(response.json);
  }

  @override
  Future<void> submitSurveyAnswer(
    Map<String, dynamic> body,
  ) async {
    await Future.delayed(fakeApiDuration);
    final response = FakeData.apiAndResponse[keySubmitSurvey]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
  }
}
