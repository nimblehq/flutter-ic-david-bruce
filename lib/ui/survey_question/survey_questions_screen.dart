import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_question_views/survey_question_view.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_screen_builder.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_state.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_view_model.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_questions_ui_model.dart';
import 'package:survey_flutter_ic/usecases/get_current_survey_use_case.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';

final surveyQuestionsViewModelProvider = StateNotifierProvider.autoDispose<
    SurveyQuestionsViewModel, SurveyQuestionsState>(
  (_) => SurveyQuestionsViewModel(
    getIt.get<GetCurrentSurveyUseCase>(),
  ),
);

class SurveyQuestionsScreen extends ConsumerStatefulWidget {
  final String surveyId;
  final int questionNumber;

  const SurveyQuestionsScreen({
    super.key,
    required this.surveyId,
    required this.questionNumber,
  });

  @override
  SurveyQuestionsScreenState createState() => SurveyQuestionsScreenState();
}

class SurveyQuestionsScreenState extends ConsumerState<SurveyQuestionsScreen> {
  Map<String, String> arguments(BuildContext context) =>
      ModalRoute.of(context)?.settings.arguments as Map<String, String>;

  @override
  void initState() {
    super.initState();
    _setUpData();
  }

  @override
  Widget build(BuildContext context) {
    _setupStateListener();
    return Consumer(
      builder: (_, ref, __) {
        final state = ref.watch(surveyQuestionsViewModelProvider);
        return state.maybeWhen(
          orElse: () {
            return Container();
          },
          submitting: _buildQuestionView,
          submitted: _buildQuestionView,
          success: _buildQuestionView,
          error: (uiModel, _) => _buildQuestionView(uiModel),
        );
      },
    );
  }

  Widget _buildQuestionView(SurveyQuestionsUIModel uiModel) =>
      SurveyQuestionView(
        uiModel: uiModel.question,
        child: buildAnswer(uiModel.answer),
        onNextQuestion: () => {},
        onSubmit: () => {},
      );

  void _setUpData() {
    Future.delayed(Duration.zero, () {
      ref
          .read(surveyQuestionsViewModelProvider.notifier)
          .setUpData(arguments: arguments(context));
    });
  }

  void _setupStateListener() {
    ref.listen<SurveyQuestionsState>(surveyQuestionsViewModelProvider,
        (_, state) {
      state.maybeWhen(
        orElse: () {},
        submitting: (_) {
          context.displayLoadingDialog(showOrHide: true);
        },
        submitted: (_) {
          context.displayLoadingDialog(showOrHide: false);
          context.showLottie(
            onAnimated: () => context.pushReplacementNamed(RoutePath.home.name),
          );
        },
        error: (_, error) {
          context.displayLoadingDialog(showOrHide: false);
          context.showMessageSnackBar(
            message: '${context.localization.pleaseTryAgain} $error.',
          );
        },
      );
    });
  }
}
