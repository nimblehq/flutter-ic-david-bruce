import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_footer_widget.dart';
import 'package:survey_flutter_ic/ui/home/home_header_widget.dart';
import 'package:survey_flutter_ic/ui/home/home_state.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

import '../../di/di.dart';
import '../../gen/assets.gen.dart';
import '../../usecases/get_surveys_use_case.dart';
import 'home_side_menu.dart';
import 'home_side_menu_ui_model.dart';

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
  final _pageController = PageController();
  final _currentPageIndex = ValueNotifier<int>(0);

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

  List<Widget> _homeBackground(List<SurveyModel>? surveys) {
    if (surveys == null || surveys.isEmpty) {
      return [_emptyBackground];
    } else {
      return surveys.map((item) => _imageBackground(item)).toList();
    }
  }

  Widget _homeHeaderWidget({
    required BuildContext context,
    required VoidCallback openSideMenuCallback,
  }) {
    return HomeHeaderWidget(
      profileImgUrl:
          'https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d',
      profileImgClickCallback: openSideMenuCallback,
    );
  }

  Widget _homeFooterWidget(SurveyModel? survey) => HomeFooterWidget(survey);

  // Widget _surveyList(List<SurveyModel> surveys) => Container(
  //       margin: const EdgeInsets.only(top: 120),
  //       child: SurveyList(
  //         refreshStyle: RefreshStyle.pullDownToRefresh,
  //         surveys: surveys,
  //         itemController: _pageController,
  //         onItemChange: _currentPageIndex,
  //         onRefresh: () => _fetchSurveys(isRefresh: true),
  //         onLoadMore: () => _fetchSurveys(isRefresh: false),
  //       ),
  //     );
  //
  Widget _pageIndicatorWidget(BuildContext context, int length) =>
      SmoothPageIndicator(
        controller: _pageController,
        count: length,
        effect: const ScrollingDotsEffect(
          dotColor: Colors.white24,
          activeDotColor: Colors.white,
          dotHeight: 8,
          dotWidth: 8,
        ),
      );

  //
  // Widget _mainBody(BuildContext context) => Consumer(
  //       builder: (_, ref, __) {
  //         final surveys = ref.watch(surveysStream).value ?? [];
  //         if (_pageController.positions.isNotEmpty) {
  //           Future.delayed(
  //             const Duration(milliseconds: 50),
  //             () {
  //               final index = ref.read(focusedItemIndexStream).value ?? 0;
  //               _pageController.jumpToPage(index);
  //             },
  //           );
  //         }
  //         return Stack(
  //           children: [
  //             _homeHeader,
  //             _pageIndicatorSection(context, surveys.length),
  //             _surveyList(surveys),
  //           ],
  //         );
  //       },
  //     );
  //
  // Widget get _takeSurveyButton => Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: FloatingActionButton(
  //           key: const Key('take survey button'),
  //           foregroundColor: Colors.black,
  //           backgroundColor: Colors.white,
  //           child: const Icon(Icons.navigate_next),
  //           onPressed: () {}),
  //     );
  //
  // Widget _body(BuildContext context) =>
  //     Consumer(
  //       builder: (_, ref, __) {
  //         final surveys = ref
  //             .watch(surveysStream)
  //             .value ?? [];
  //         return SafeArea(child: _mainBody(context));
  //       },
  //     );

  @override
  void initState() {
    super.initState();
    ref.read(homeViewModelProvider.notifier).getSurveys();
  }

  @override
  void dispose() {
    _currentPageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    _setupStateListener();
    return Scaffold(
      key: scaffoldKey,
      endDrawer: _sideMenu,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => _currentPageIndex.value = index,
            children: _homeBackground(ref.watch(surveysStream).value),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(Dimensions.paddingMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _homeHeaderWidget(
                    context: context,
                    openSideMenuCallback: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                  const Spacer(),
                  _pageIndicatorWidget(
                    context,
                    ref.watch(surveysStream).value?.length ?? 0,
                  ),
                  const SizedBox(height: Dimensions.paddingLarge),
                  _homeFooterWidget(
                    ref
                        .watch(surveysStream)
                        .value
                        ?.elementAt(_currentPageIndex.value),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _setupStateListener() {
    _currentPageIndex.addListener(() {
      ref
          .read(homeViewModelProvider.notifier)
          .changeFocusedItem(index: _currentPageIndex.value);
    });
  }

  Future<void> _fetchSurveys({required bool isRefresh}) async {
    ref.read(homeViewModelProvider.notifier).getSurveys(isRefresh: isRefresh);
  }
}

enum RefreshStyle {
  swipeRightToRefresh,
  pullDownToRefresh,
}

// class SurveyList extends StatelessWidget {
//   final RefreshStyle refreshStyle;
//   final List<SurveyModel> surveys;
//   final PageController itemController;
//   final ValueNotifier<int> onItemChange;
//   final Future<void> Function() onRefresh;
//   final Future<void> Function() onLoadMore;
//
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       GlobalKey<RefreshIndicatorState>();
//   bool _isLoading = false;
//
//   SurveyList({
//     super.key,
//     required this.refreshStyle,
//     required this.surveys,
//     required this.itemController,
//     required this.onItemChange,
//     required this.onRefresh,
//     required this.onLoadMore,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     _isLoading = false;
//     return _buildSwipeRightToRefreshPageView(context);
//   }
//
//   Widget _buildSwipeRightToRefreshPageView(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     itemController.addListener(() {
//       if (itemController.offset < -10) {
//         _refreshIndicatorKey.currentState?.show();
//       }
//
//       if (itemController.offset > screenWidth * (surveys.length - 1) + 10 &&
//           !_isLoading) {
//         _isLoading = true;
//         onLoadMore();
//       }
//     });
//     return RefreshIndicator(
//       key: _refreshIndicatorKey,
//       onRefresh: onRefresh,
//       child: PageView.builder(
//         scrollDirection: Axis.horizontal,
//         controller: itemController,
//         onPageChanged: (index) => onItemChange.value = index,
//         itemCount: surveys.length,
//         itemBuilder: (context, index) => SurveyCell(surveys[index]),
//       ),
//     );
//   }
// }
