import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_state.dart';

import '../../usecases/get_surveys_use_case.dart';
import 'home_screen.dart';

final profileImageUrlStream = StreamProvider.autoDispose<String>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._profileImageUrlStream.stream);

final surveysStream = StreamProvider.autoDispose<List<SurveyModel>>(
    (ref) => ref.watch(homeViewModelProvider.notifier)._surveysStream.stream);

final focusedItemIndexStream = StreamProvider.autoDispose<int>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._focusedItemIndexStream.stream);

class HomeViewModel extends StateNotifier<HomeState> {
  final StreamController<String> _profileImageUrlStream = StreamController();
  final StreamController<List<SurveyModel>> _surveysStream = StreamController();
  final StreamController<int> _focusedItemIndexStream = StreamController();

  final GetSurveysUseCase getSurveysUseCase;

  final List<SurveyModel> _surveys = [
    const SurveyModel(
        id: "id1",
        title: "Scarlett Bangkok",
        description: "We'd love ot hear from you!",
        thankEmailAboveThreshold: "",
        thankEmailBelowThreshold: "",
        isActive: true,
        coverImageUrl:
            "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
        createdAt: "2017-01-23T07:48:12.991Z",
        activeAt: "2015-10-08T07:04:00.000Z",
        inactiveAt: "",
        surveyType: "restaurant"),
    const SurveyModel(
      id: "id2",
      title: "ibis Bangkok Riverside",
      description: "We'd love ot hear from you!",
      thankEmailAboveThreshold: "",
      thankEmailBelowThreshold: "",
      isActive: true,
      coverImageUrl:
          "https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_",
      createdAt: "2017-01-23T07:48:12.991Z",
      activeAt: "2015-10-08T07:04:00.000Z",
      inactiveAt: "",
      surveyType: "restaurant",
    )
  ];
  int _focusedItemIndex = 0;

  HomeViewModel({required this.getSurveysUseCase})
      : super(const HomeState.init());

  void getSurveys({bool isRefresh = false}) async {
    // final result = await getSurveysUseCase.call(SurveysParams(
    //   pageNumber: 1,
    //   pageSize: 2,
    // ));
    // if (result is Success<SurveysModel>) {
    //   final newSurveys = result.value.surveys;
    //   _surveysStream.add(newSurveys);
    // } else {
    //   state = HomeState.error(NetworkExceptions.getErrorMessage(
    //       (result as Failed).exception.actualException));
    // }
    _surveysStream.add(_surveys);
  }

  void changeFocusedItem({required int index}) {
    _focusedItemIndex = index;
    _focusedItemIndexStream.add(index);
  }
}
