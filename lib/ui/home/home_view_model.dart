import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/model/survey_meta_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_state.dart';

import '../../api/exception/network_exceptions.dart';
import '../../model/surveys_model.dart';
import '../../usecases/base/base_use_case.dart';
import '../../usecases/get_surveys_use_case.dart';
import '../../usecases/params/surveys_params.dart';
import 'home_screen.dart';

final surveysStream = StreamProvider.autoDispose<List<SurveyModel>>(
    (ref) => ref.watch(homeViewModelProvider.notifier)._surveysStream.stream);

final focusedItemIndexStream = StreamProvider.autoDispose<int>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._focusedItemIndexStream.stream);

const _pageDefault = 1;
const _pageSizeDefault = 5;

class HomeViewModel extends StateNotifier<HomeState> {
  final StreamController<List<SurveyModel>> _surveysStream = StreamController();
  final StreamController<int> _focusedItemIndexStream = StreamController();

  final GetSurveysUseCase getSurveysUseCase;

  LoadMoreDataSet _loadMoreDataSet = LoadMoreDataSet();

  HomeViewModel({required this.getSurveysUseCase})
      : super(const HomeState.init());

  void getSurveys({bool isRefresh = false}) async {
    if (isRefresh) {
      _loadMoreDataSet = LoadMoreDataSet();
    }

    if (!_loadMoreDataSet.isHasMore || _loadMoreDataSet.isLoading) return;
    _loadMoreDataSet.isLoading = true;

    final result = await getSurveysUseCase.call(SurveysParams(
      pageNumber: _loadMoreDataSet.page,
      pageSize: _loadMoreDataSet.pageSize,
    ));
    if (result is Success<SurveysModel>) {
      final newSurveys = result.value.surveys;
      calculateLoadMoreDataSet(result.value.meta);
      _surveysStream.add(newSurveys);
    } else {
      state = HomeState.error(NetworkExceptions.getErrorMessage(
          (result as Failed).exception.actualException));
      _loadMoreDataSet.isLoading = false;
    }
  }

  void changeFocusedItem({required int index}) {
    _focusedItemIndexStream.add(index);
  }

  void calculateLoadMoreDataSet(SurveyMetaModel meta) {
    _loadMoreDataSet.isLoading = false;
    _loadMoreDataSet.page = meta.page + 1;
    if (_loadMoreDataSet.page > meta.pages) {
      _loadMoreDataSet.isHasMore = false;
    }
  }
}

class LoadMoreDataSet {
  int page = _pageDefault;
  int pageSize = _pageSizeDefault;
  bool isHasMore = true;
  bool isLoading = false;
}
