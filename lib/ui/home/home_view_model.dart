import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/model/survey_meta_model.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_state.dart';
import 'package:survey_flutter_ic/usecases/get_surveys_use_case.dart';
import 'package:survey_flutter_ic/usecases/save_surveys_use_case.dart';

import '../../api/exception/network_exceptions.dart';
import '../../model/surveys_model.dart';
import '../../usecases/base/base_use_case.dart';
import '../../usecases/fetch_surveys_use_case.dart';
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

  final FetchSurveysUseCase fetchSurveysUseCase;
  final GetSurveysUseCase getSurveysUseCase;
  final SaveSurveysUseCase saveSurveysUseCase;

  _LoadMoreDataSet _loadMoreDataSet = _LoadMoreDataSet();
  final List<SurveyModel> _totalSurveys = List.empty(growable: true);

  HomeViewModel({
    required this.fetchSurveysUseCase,
    required this.getSurveysUseCase,
    required this.saveSurveysUseCase,
  }) : super(const HomeState.init());

  Future<void> getSurveys() async {
    _resetLoadMoreDataSet();
    final result = await getSurveysUseCase.call(SurveysParams(
      pageNumber: _loadMoreDataSet.page,
      pageSize: _loadMoreDataSet.pageSize,
    ));
    _handleResult(result);
  }

  Future<void> fetchSurveys({bool isRefresh = false}) async {
    if (isRefresh) {
      _resetLoadMoreDataSet();
    }
    if (!_loadMoreDataSet.isHasMore || _loadMoreDataSet.isLoading) return;
    _loadMoreDataSet.isLoading = true;
    final result = await fetchSurveysUseCase.call(SurveysParams(
      pageNumber: _loadMoreDataSet.page,
      pageSize: _loadMoreDataSet.pageSize,
    ));
    _handleResult(result);
    if (result is Success<SurveysModel>) {
      await saveSurveysUseCase.call(SurveysModel(
        surveys: _totalSurveys,
        meta: result.value.meta,
      ));
    }
  }

  void changeFocusedItem({required int index}) {
    _focusedItemIndexStream.add(index);
  }

  void _calculateLoadMoreDataSet(SurveyMetaModel meta) {
    _loadMoreDataSet.isLoading = false;
    _loadMoreDataSet.page = meta.page + 1;
    if (_loadMoreDataSet.page > meta.pages) {
      _loadMoreDataSet.isHasMore = false;
    }
  }

  void _handleResult(Result<SurveysModel> result) {
    if (result is Success<SurveysModel>) {
      final newSurveys = result.value.surveys;
      _calculateLoadMoreDataSet(result.value.meta);
      _totalSurveys.addAll(newSurveys);
      _surveysStream.add(_totalSurveys);
    } else {
      state = HomeState.error(NetworkExceptions.getErrorMessage(
          (result as Failed).exception.actualException));
      _loadMoreDataSet.isLoading = false;
    }
  }

  void _resetLoadMoreDataSet() {
    _loadMoreDataSet = _LoadMoreDataSet();
    _focusedItemIndexStream.add(0);
    _totalSurveys.clear();
  }
}

class _LoadMoreDataSet {
  int page = _pageDefault;
  int pageSize = _pageSizeDefault;
  bool isHasMore = true;
  bool isLoading = false;
}
