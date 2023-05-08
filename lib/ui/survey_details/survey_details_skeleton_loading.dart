import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:survey_flutter_ic/ui/home/loading/home_loading_text.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    HomeLoadingText(width: 120.0),
                    SizedBox(height: Dimensions.paddingDefault),
                    HomeLoadingText(width: 100.0),
                  ],
                ),
                const SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
