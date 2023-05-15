// ignore_for_file: avoid_init_to_null
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

extension CustomAppBar on AppBar {
  static AppBar backButton({
    required BuildContext context,
    void Function()? onPressed = null,
  }) =>
      AppBar(
        leading: BackButton(onPressed: () {
          if (onPressed != null) {
            onPressed();
          } else if (context.canPop()) {
            context.pop();
          }
        }),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      );

  static AppBar closeButton({
    required BuildContext context,
    void Function()? onPressed = null,
  }) =>
      AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.paddingNormal),
            child: ElevatedButton(
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                } else if (context.canPop()) {
                  context.pop();
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(Dimensions.paddingSmallest),
                backgroundColor: Colors.white24,
                foregroundColor: Colors.black26,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      );
}
