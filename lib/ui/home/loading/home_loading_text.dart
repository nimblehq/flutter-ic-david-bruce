import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class HomeLoadingText extends StatelessWidget {
  final double width;

  const HomeLoadingText({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingNormal),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        child: Container(
          width: width,
          height: 12.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
