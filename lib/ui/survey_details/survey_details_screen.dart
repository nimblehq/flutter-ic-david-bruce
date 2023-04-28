import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_detail_view_model.dart';
import 'package:survey_flutter_ic/ui/survey_details/survey_details_state.dart';
import 'package:survey_flutter_ic/usecases/get_survey_details_use_case.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';

final surveyDetailsViewModelProvider = StateNotifierProvider.autoDispose<
    SurveyDetailsViewModel, SurveyDetailsState>(
  (_) => SurveyDetailsViewModel(getIt.get<GetSurveyDetailsUseCase>()),
);

class SurveyDetailsScreen extends ConsumerStatefulWidget {
  const SurveyDetailsScreen({super.key});

  @override
  ConsumerState<SurveyDetailsScreen> createState() =>
      SurveyDetailsScreenState();
}

class SurveyDetailsScreenState extends ConsumerState<SurveyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    _registerStateListener();
    return Stack(
      children: const [],
    );
  }

  void _registerStateListener() {
    ref.listen<SurveyDetailsState>(surveyDetailsViewModelProvider, (_, state) {
      context.displayLoadingDialog(
        showOrHide: state == const SurveyDetailsState.loading(),
      );
      state.maybeWhen(
        success: null,
        error: (errorMessage) => context.showMessageSnackBar(
          message: errorMessage,
        ),
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
