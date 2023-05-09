import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';

import '../../model/survey_model.dart';

class HomeFooterWidget extends StatelessWidget {
  final List<SurveyModel> surveys;
  final PageController pageController;
  final Function(int) onPageChangedCallback;

  const HomeFooterWidget({
    required this.surveys,
    required this.pageController,
    required this.onPageChangedCallback,
    super.key,
  });

  Widget footerWidget(BuildContext context, SurveyModel survey) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                survey.title,
                style: context.textTheme.displayMedium,
                maxLines: 2,
              ),
              const SizedBox(height: Dimensions.paddingNormal),
              Text(
                survey.description,
                style: context.textTheme.bodyMedium,
                maxLines: 2,
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black26,
            padding: const EdgeInsets.all(Dimensions.paddingNormal),
          ),
          child: const Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
          onPressed: () {
            var params = <String, String>{};
            params[RoutePath.surveyDetails.pathParam] = _survey?.id ?? '';
            context.pushNamed(RoutePath.surveyDetails.name, params: params);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: surveys.length,
      onPageChanged: (index) => onPageChangedCallback(index),
      itemBuilder: (_, index) => footerWidget(context, surveys[index]),
    );
  }
}
