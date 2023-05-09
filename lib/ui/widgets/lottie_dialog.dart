import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';

class LottieDialog extends StatefulWidget {
  final Function() onAnimated;

  const LottieDialog({
    super.key,
    required this.onAnimated,
  });

  @override
  State<LottieDialog> createState() => _LottieDialogState();
}

class _LottieDialogState extends State<LottieDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        width: context.screenSize.width,
        height: context.screenSize.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/submit_successfully.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.forward().then(
                      (_) => Future.delayed(const Duration(seconds: 2),
                          () => widget.onAnimated()),
                    );
              },
            ),
            const SizedBox(height: 20),
            Text(
              context.localization.surveyThanks,
              style: context.textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
