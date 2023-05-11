import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_question_component_id.dart';
import 'package:survey_flutter_ic/ui/survey_question/survey_questions_screen.dart';
import 'package:survey_flutter_ic/ui/survey_question/ui_models/survey_question_ui_model.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/custom_app_bar.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';

class SurveyQuestionView extends StatelessWidget {
  final SurveyQuestionUIModel uiModel;
  final Widget child;
  final Function() onNextQuestion;
  final Function() onSubmit;

  const SurveyQuestionView({
    super.key,
    required this.uiModel,
    required this.child,
    required this.onNextQuestion,
    required this.onSubmit,
  });

  AppBar _appBar(BuildContext context) => CustomAppBar.closeButton(
        context: context,
        onPressed: () => context.pushReplacementNamed(
          RoutePath.home.name,
        ),
      );

  Widget _background(BuildContext context) => SizedBox(
        width: context.screenSize.width,
        height: context.screenSize.height,
        child: Image(
          image: Assets.images.bgLoginOverlay.image().image,
          fit: BoxFit.cover,
        ),
      );

  Widget _mainBody(BuildContext context) => Container(
        width: context.screenSize.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _questionNumber(context),
            const SizedBox(
              height: 16,
            ),
            _questionTitle(context),
            Expanded(child: child),
          ],
        ),
      );

  Widget _questionNumber(BuildContext context) =>
      Consumer(builder: (_, ref, __) {
        final state = ref.watch(surveyQuestionsViewModelProvider);
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          success: (uiModel) => Text(
            uiModel.question.currentIndexPerTotal,
            style: context.textTheme.bodyMedium,
          ),
        );
      });

  Widget _questionTitle(BuildContext context) => Text(
        uiModel.title,
        style: context.textTheme.displayMedium,
      );

  Widget _floatingActionButton(BuildContext context) {
    final isLastQuestion = uiModel.totalQuestions > 0 &&
        uiModel.questionIndex == uiModel.totalQuestions;
    return isLastQuestion ? _submitButton(context) : _nextButton;
  }

  Widget get _nextButton => Padding(
        key: SurveyQuestionComponentId.nextButton,
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: () => {onNextQuestion()},
          child: const Icon(Icons.navigate_next),
        ),
      );

  Widget _submitButton(BuildContext context) => Padding(
        key: SurveyQuestionComponentId.submitButton,
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(140, 56)),
          onPressed: onSubmit,
          child: Text(context.localization.surveyDetailsSubmit),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background(context),
        Container(color: Colors.black38),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar(context),
          body: SafeArea(child: _mainBody(context)),
          floatingActionButton: _floatingActionButton(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        )
      ],
    );
  }
}
