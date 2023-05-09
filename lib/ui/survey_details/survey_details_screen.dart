import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_component_id.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_skeleton_loading.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_ui_model.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_view_model.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_state.dart';
import 'package:survey_flutter_ic/usecases/get_survey_details_use_case.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/custom_app_bar.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

final surveyDetailsViewModelProvider = StateNotifierProvider.autoDispose<
    SurveyDetailsViewModel, SurveyDetailsState>(
  (_) => SurveyDetailsViewModel(getIt.get<GetSurveyDetailsUseCase>()),
);

class SurveyDetailsScreen extends ConsumerStatefulWidget {
  final String surveyId;

  const SurveyDetailsScreen({
    required this.surveyId,
    super.key,
  });

  @override
  ConsumerState<SurveyDetailsScreen> createState() =>
      SurveyDetailsScreenState();
}

class SurveyDetailsScreenState extends ConsumerState<SurveyDetailsScreen> {
  AppBar get _appBar => CustomAppBar.backButton(context: context);

  Widget get _background => SizedBox(
        width: context.screenSize.width,
        height: context.screenSize.height,
        child: Consumer(
          builder: (_, ref, __) {
            final state = ref.watch(surveyDetailsViewModelProvider);
            return state.maybeWhen(
              success: (uiModel) => FadeInImage.assetNetwork(
                placeholder: Assets.images.bgLoginOverlay.path,
                image: uiModel.imageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              orElse: () => _defaultBackground,
            );
          },
        ),
      );

  Widget get _defaultBackground => Image(
        image: Assets.images.bgLoginOverlay.image().image,
        fit: BoxFit.cover,
      );

  Widget get _emptyBody => Container();

  Widget get _body => Consumer(
        builder: (_, ref, __) {
          final state = ref.watch(surveyDetailsViewModelProvider);
          return state.maybeWhen(
            loading: () => const SurveyDetailsSkeletonLoading(),
            success: (uiModel) => _surveyDetails(uiModel),
            orElse: () => _emptyBody,
          );
        },
      );

  Widget _surveyDetails(SurveyDetailsUIModel uiModel) => Consumer(
        builder: (_, ref, __) {
          return Container(
            width: context.screenSize.width,
            padding: const EdgeInsets.all(Dimensions.paddingMedium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  uiModel.title,
                  style: context.textTheme.displayLarge,
                ),
                const SizedBox(height: Dimensions.paddingNormal),
                Text(
                  uiModel.description,
                  style: context.textTheme.bodyMedium,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      key: SurveyDetailsComponentId.startSurveyButton,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                          Dimensions.buttonWidth,
                          Dimensions.buttonHeight,
                        ),
                      ),
                      onPressed: () => _startSurvey(),
                      child:
                          Text(context.localization.surveyDetailsStartSurvey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );

  @override
  void initState() {
    super.initState();
    _getSurveyDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background,
        Container(color: Colors.black38),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar,
          body: SafeArea(child: _body),
        )
      ],
    );
  }

  void _getSurveyDetails() {
    ref
        .read(surveyDetailsViewModelProvider.notifier)
        .getSurveyDetails(widget.surveyId);
  }

  void _startSurvey() {}
}
