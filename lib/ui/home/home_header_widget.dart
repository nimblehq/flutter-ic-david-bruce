import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

import '../../gen/assets.gen.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String profileImgUrl;
  final VoidCallback? profileImgClickCallback;

  const HomeHeaderWidget({
    super.key,
    required this.profileImgUrl,
    required this.profileImgClickCallback,
  });

  String get _todayDate {
    final today = DateTime.now();
    return '${DateFormat.EEEE().format(today)}, ${DateFormat.MMMMd().format(today)}'
        .toUpperCase();
  }

  Text _dateTodayText(BuildContext context) => Text(
        _todayDate,
        style: context.textTheme.labelMedium,
      );

  Text _todayText(BuildContext context) => Text(
        context.localization.today,
        style: context.textTheme.displayLarge,
      );

  FadeInImage get _profileImg => FadeInImage.assetNetwork(
        placeholder: Assets.images.nimbleLogo.path,
        image: profileImgUrl,
      );

  Widget _profilePictureWidget(BuildContext context) => Consumer(
        builder: (_, ref, __) {
          return GestureDetector(
            onTap: profileImgClickCallback,
            child: SizedBox(
              width: 36,
              height: 36,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: _profileImg.image,
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dateTodayText(context),
          const SizedBox(height: Dimensions.paddingTiny),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _todayText(context),
              _profilePictureWidget(context),
            ],
          ),
        ],
      ),
    );
  }
}
