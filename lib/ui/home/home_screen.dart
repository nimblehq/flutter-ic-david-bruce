import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:survey_flutter_ic/model/survey_model.dart';
import 'package:survey_flutter_ic/ui/home/home_state.dart';
import 'package:survey_flutter_ic/ui/home/home_view_model.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/home/loading/home_loading.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';

import '../../di/di.dart';
import '../../usecases/get_surveys_use_case.dart';
import '../../utils/route_path.dart';

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
  final _surveyItemController = PageController();
  final _surveyIndex = ValueNotifier<int>(0);

  Widget get _background => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Consumer(builder: (_, ref, __) {
          final index = ref.watch(focusedItemIndexStream).value ?? 0;
          final surveys = ref.watch(surveysStream).value ?? [];
          return surveys.isEmpty || index >= surveys.length
              ? Image(
                  image: Assets.images.bgLoginOverlay.image().image,
                  fit: BoxFit.cover,
                )
              : FadeInImage.assetNetwork(
                  placeholder: Assets.images.bgLoginOverlay.path,
                  image: surveys[index].coverImageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                );
        }),
      );

  Widget get _homeHeader => Consumer(
        builder: (_, ref, __) {
          return HomeHeader(
              profileImageUrl: ref.watch(profileImageUrlStream).value ?? '');
        },
      );

  Widget _surveyList(List<SurveyModel> surveys) => Container(
        margin: const EdgeInsets.only(top: 120),
        child: SurveyList(
          refreshStyle: RefreshStyle.pullDownToRefresh,
          surveys: surveys,
          itemController: _surveyItemController,
          onItemChange: _surveyIndex,
          onRefresh: () => _fetchSurveys(isRefresh: true),
          onLoadMore: () => _fetchSurveys(isRefresh: false),
        ),
      );

  Widget _pageIndicatorSection(BuildContext context, int length) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          SurveyPageIndicator(
            controller: _surveyItemController,
            count: length,
          ),
          SizedBox(height: 230.0 - MediaQuery.of(context).padding.bottom),
        ],
      );

  Widget _mainBody(BuildContext context) => Consumer(
        builder: (_, ref, __) {
          final surveys = ref.watch(surveysStream).value ?? [];
          if (_surveyItemController.positions.isNotEmpty) {
            Future.delayed(
              const Duration(milliseconds: 50),
              () {
                final index = ref.read(focusedItemIndexStream).value ?? 0;
                _surveyItemController.jumpToPage(index);
              },
            );
          }
          return Stack(
            children: [
              _homeHeader,
              _pageIndicatorSection(context, surveys.length),
              _surveyList(surveys),
            ],
          );
        },
      );

  Widget get _takeSurveyButton => Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            key: const Key('take survey button'),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            child: const Icon(Icons.navigate_next),
            onPressed: () {}),
      );

  Widget _body(BuildContext context) => Consumer(
        builder: (_, ref, __) {
          final surveys = ref.watch(surveysStream).value ?? [];
          return surveys.isNotEmpty
              ? SafeArea(child: _mainBody(context))
              : const SafeArea(child: HomeLoading());
        },
      );

  @override
  void initState() {
    super.initState();
    ref.read(homeViewModelProvider.notifier).getSurveys();
  }

  @override
  void dispose() {
    _surveyIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setupStateListener();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      endDrawer: Drawer(
          backgroundColor: const Color(0xFF1E1E1E),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Mai',
                              style: context.textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              size: 36.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.white70,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        context.localization.logout,
                        style: context.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white70),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ListTile(
                  title: Text(
                    'Version 1.0',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: Colors.white70),
                  ),
                ),
              ),
            ],
          )),
      body: Stack(
        children: [
          _background,
          Container(color: Colors.black38),
          _body(context),
        ],
      ),
      floatingActionButton: _takeSurveyButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void _setupStateListener() {
    _surveyIndex.addListener(() {
      ref
          .read(homeViewModelProvider.notifier)
          .changeFocusedItem(index: _surveyIndex.value);
    });
  }

  Future<void> _fetchSurveys({required bool isRefresh}) async {}
}

class HomeHeader extends StatelessWidget {
  final String profileImageUrl;

  const HomeHeader({
    super.key,
    required this.profileImageUrl,
  });

  String get _dateText {
    final today = DateTime.now();
    return '${DateFormat.EEEE().format(today)}, ${DateFormat.MMMMd().format(today)}';
  }

  Widget _dateWidget(BuildContext context) => Text(
        _dateText.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium,
      );

  Widget _todayWidget(BuildContext context) => Text(
        context.localization.today,
        style: Theme.of(context).textTheme.displayLarge,
      );

  Image get _defaultProfileImage => Assets.images.nimbleLogo.image();

  FadeInImage get _profileImage => FadeInImage.assetNetwork(
        placeholder: Assets.images.nimbleLogo.path,
        image: profileImageUrl,
      );

  Widget _profilePictureWidget(BuildContext context) => Consumer(
        builder: (_, ref, __) {
          return GestureDetector(
            onTap: () {
              context.goNamed(RoutePath.login.name);
            },
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: profileImageUrl.isEmpty
                    ? _defaultProfileImage.image
                    : _profileImage.image,
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dateWidget(context),
                const SizedBox(height: 4),
                _todayWidget(context),
              ],
            ),
          ),
          _profilePictureWidget(context),
        ],
      ),
    );
  }
}

enum RefreshStyle {
  swipeRightToRefresh,
  pullDownToRefresh,
}

class SurveyList extends StatelessWidget {
  final RefreshStyle refreshStyle;
  final List<SurveyModel> surveys;
  final PageController itemController;
  final ValueNotifier<int> onItemChange;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  SurveyList({
    super.key,
    required this.refreshStyle,
    required this.surveys,
    required this.itemController,
    required this.onItemChange,
    required this.onRefresh,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    _isLoading = false;
    return _buildSwipeRightToRefreshPageView(context);
  }

  Widget _buildSwipeRightToRefreshPageView(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    itemController.addListener(() {
      if (itemController.offset < -10) {
        _refreshIndicatorKey.currentState?.show();
      }

      if (itemController.offset > screenWidth * (surveys.length - 1) + 10 &&
          !_isLoading) {
        _isLoading = true;
        onLoadMore();
      }
    });
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: onRefresh,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: itemController,
        onPageChanged: (index) => onItemChange.value = index,
        itemCount: surveys.length,
        itemBuilder: (context, index) => SurveyCell(surveys[index]),
      ),
    );
  }
}

class SurveyCell extends StatelessWidget {
  final SurveyModel _survey;

  const SurveyCell(this._survey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _survey.title,
                    style: Theme.of(context).textTheme.displayMedium,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 16),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _survey.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SurveyPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const SurveyPageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SmoothPageIndicator(
          controller: controller,
          count: count,
          effect: const ScrollingDotsEffect(
            dotWidth: 8,
            dotHeight: 8,
            radius: 8,
            spacing: 10,
            dotColor: Colors.white30,
            activeDotColor: Colors.white,
          ),
        ));
  }

  SizedBox _backgroundImage(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image(
        image: AssetImage(Assets.images.bgHomeOverlay.path),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  Drawer _buildMenu(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xFF1E1E1E),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Mai',
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            size: 36.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      color: Colors.white70,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      context.localization.logout,
                      style: context.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white70),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ListTile(
                title: Text(
                  'Version 1.0',
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
              ),
            ),
          ],
        ));
  }
}
