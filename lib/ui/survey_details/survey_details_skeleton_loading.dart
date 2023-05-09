import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';
import 'package:survey_flutter_ic/utils/loading_text.dart';

class SurveyDetailsSkeletonLoading extends StatelessWidget {
  const SurveyDetailsSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white38,
      highlightColor: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: Dimensions.paddingSmall,
              right: Dimensions.paddingMedium,
              bottom: Dimensions.paddingSmall,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                LoadingText(width: MediaQuery.of(context).size.width - 20.0),
                const SizedBox(height: Dimensions.paddingTiny),
                const LoadingText(width: 120.0),
                const SizedBox(height: Dimensions.paddingNormal),
                LoadingText(width: MediaQuery.of(context).size.width - 20.0),
                const SizedBox(height: Dimensions.paddingTiny),
                LoadingText(width: MediaQuery.of(context).size.width - 20.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
