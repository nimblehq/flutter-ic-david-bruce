import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
          _buildTopSkeleton(),
          _buildBottomSkeleton(context),
        ],
      ),
    );
  }

  Widget _buildTopSkeleton() => Container(
        padding: const EdgeInsets.only(
          top: 10,
          right: 20,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );

  Widget _buildBottomSkeleton(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: const [
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
          ],
        ),
      );
}
