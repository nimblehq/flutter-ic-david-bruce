import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_footer_widget.dart';
import 'package:survey_flutter_ic/ui/home/home_header_widget.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu_ui_model.dart';
import 'package:survey_flutter_ic/ui/home/home_state.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/loading/home_skeleton_loading.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

import '../../di/di.dart';
import '../../gen/assets.gen.dart';
import '../../usecases/get_surveys_use_case.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (_) => HomeViewModel(
    getSurveysUseCase: getIt.get<GetSurveysUseCase>(),
  ),
);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final _currentPageIndex = ValueNotifier<int>(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  PageController _pageController = PageController(initialPage: 0);

  SideMenu get _sideMenu => SideMenu(
        sideMenuUIModel: SideMenuUIModel(
          name: 'Mai',
          version: 'v0.1.0 (1562903885)',
        ),
      );

  Widget _imageBackground(SurveyModel surveyModel) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FadeInImage.assetNetwork(
              placeholder: Assets.images.nimbleLogo.path,
              image: surveyModel.coverImageUrl,
            ).image,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.darken,
            ),
          ),
        ),
      );

  Widget get _emptyBackground => Image(
        image: AssetImage(Assets.images.bgLoginOverlay.path),
        fit: BoxFit.fill,
      );

  Widget _homeBackground(List<SurveyModel> surveys, int focusedIndex) {
    return surveys.isEmpty
        ? _emptyBackground
        : _imageBackground(surveys[focusedIndex]);
  }

  Widget _homeHeaderWidget() {
    return HomeHeaderWidget(
      profileImgUrl:
          'https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d',
      profileImgClickCallback: () => _scaffoldKey.currentState?.openEndDrawer(),
    );
  }

  Widget _homeFooterWidget(List<SurveyModel> surveys) => HomeFooterWidget(
        surveys: surveys,
        pageController: _pageController,
        onPageChangedCallback: (index) => _currentPageIndex.value = index,
      );

  Widget _pageIndicatorWidget(BuildContext context, int length) => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: SmoothPageIndicator(
            controller: _pageController,
            count: length,
            effect: const WormEffect(
              dotColor: Colors.white24,
              activeDotColor: Colors.white,
              dotHeight: 8.0,
              dotWidth: 8.0,
            ),
          ),
        ),
      );

  Widget _homeWidget(BuildContext context) {
    final surveys = ref.watch(surveysStream).value ?? [];
    final focusedItemIndex = ref.watch(focusedItemIndexStream).value ?? 0;
    _pageController = PageController(initialPage: focusedItemIndex);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      endDrawer: _sideMenu,
      body: Stack(
        children: [
          Visibility(
            visible: surveys.isNotEmpty,
            child: Stack(
              children: [
                _homeBackground(surveys, focusedItemIndex),
                SafeArea(
                  child: RefreshIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    onRefresh: () => ref
                        .read(homeViewModelProvider.notifier)
                        .getSurveys(isRefresh: true),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: context.screenSize.height -
                            MediaQuery.of(context).viewPadding.vertical,
                        child: Container(
                          padding:
                              const EdgeInsets.all(Dimensions.paddingMedium),
                          child: Stack(
                            children: [
                              _homeHeaderWidget(),
                              _pageIndicatorWidget(context, surveys.length),
                              _homeFooterWidget(surveys),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: surveys.isEmpty,
            child: const SafeArea(
              child: HomeSkeletonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ref.read(homeViewModelProvider.notifier).getSurveys(isRefresh: true);
  }

  @override
  void dispose() {
    _currentPageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    _setupStateListener();
    return _homeWidget(context);
  }

  void _setupStateListener() {
    final surveys = ref.watch(surveysStream).value ?? [];
    _currentPageIndex.addListener(() {
      ref
          .read(homeViewModelProvider.notifier)
          .changeFocusedItem(index: _currentPageIndex.value);
      if (_currentPageIndex.value == surveys.length - 2) {
        ref.read(homeViewModelProvider.notifier).getSurveys(isRefresh: false);
      }
    });
  }
}
