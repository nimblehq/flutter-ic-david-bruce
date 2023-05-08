import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_footer_widget.dart';
import 'package:survey_flutter_ic/ui/home/home_header_widget.dart';
import 'package:survey_flutter_ic/ui/home/home_state.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/ui/home/loading/home_loading_text.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu_ui_model.dart';
import 'package:survey_flutter_ic/utils/loading_text.dart';
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
  final _pageController = PageController();
  final _currentPageIndex = ValueNotifier<int>(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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

  Widget _homeHeaderWidget() {
    return HomeHeaderWidget(
      profileImgUrl:
          'https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d',
      profileImgClickCallback: () => _scaffoldKey.currentState?.openEndDrawer(),
    );
  }

  Widget _homeFooterWidget() => Consumer(builder: (_, ref, __) {
        final surveys = ref.watch(surveysStream).value;
        final index = ref.watch(focusedItemIndexStream).value ?? 0;
        return HomeFooterWidget(surveys?.elementAt(index));
      });

  Widget _pageIndicatorWidget(BuildContext context, int length) =>
      SmoothPageIndicator(
        controller: _pageController,
        count: length,
        effect: const ScrollingDotsEffect(
          dotColor: Colors.white24,
          activeDotColor: Colors.white,
          dotHeight: 8.0,
          dotWidth: 8.0,
        ),
      );

  Widget _homeWidget(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  _homeHeaderWidget(),
                  const Spacer(),
                  _pageIndicatorWidget(
                    context,
                    ref.watch(surveysStream).value?.length ?? 0,
                  ),
                  const SizedBox(height: Dimensions.paddingLarge),
                  _homeFooterWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    _setupStateListener();
    final surveys = ref.watch(surveysStream).value ?? [];
    return surveys.isNotEmpty
        ? _homeWidget(context)
        : const SafeArea(child: LoadingText());
  }

  void _setupStateListener() {
    _currentPageIndex.addListener(() {
      ref
          .read(homeViewModelProvider.notifier)
          .changeFocusedItem(index: _currentPageIndex.value);
    });
  }
}
