import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';

import '../../model/survey_model.dart';

class HomeFooterWidget extends StatelessWidget {
  final SurveyModel? _survey;

  const HomeFooterWidget(this._survey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _survey?.title ?? '',
          style: context.textTheme.displayMedium,
          maxLines: 2,
        ),
        const SizedBox(height: Dimensions.paddingNormal),
        Row(
          children: [
            Expanded(
              child: Text(
                _survey?.description ?? '',
                style: context.textTheme.bodyMedium,
                maxLines: 2,
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
        ),
      ],
    );
  }
}
