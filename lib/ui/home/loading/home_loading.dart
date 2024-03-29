import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';
import 'package:survey_flutter_ic/utils/loading_text.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white38,
      highlightColor: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderLoading(),
          _buildBodyLoading(context),
        ],
      ),
    );
  }

  Widget _buildHeaderLoading() => Container(
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
                LoadingText(width: 120.0),
                SizedBox(height: Dimensions.paddingTiny),
                LoadingText(width: 100.0),
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
      );

  Widget _buildBodyLoading(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const LoadingText(width: 40.0),
            const SizedBox(height: Dimensions.paddingNormal),
            LoadingText(width: context.screenSize.width - 102.0),
            const SizedBox(height: Dimensions.paddingTiny),
            LoadingText(width: context.screenSize.width - 240.0),
            const SizedBox(height: Dimensions.paddingNormal),
            LoadingText(width: context.screenSize.width - 36.0),
            const SizedBox(height: Dimensions.paddingTiny),
            LoadingText(width: context.screenSize.width - 140.0),
            const SizedBox(height: Dimensions.paddingNormal)
          ],
        ),
      );
}
