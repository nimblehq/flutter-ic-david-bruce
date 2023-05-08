import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey_flutter_ic/ui/widgets/loading_dialog.dart';
import 'package:survey_flutter_ic/ui/widgets/lottie_dialog.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  void showMessageSnackBar({required String message}) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));

  void showLottie({
    required Function() onAnimated,
  }) {
    showDialog(
      context: this,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: false,
      builder: (_) => LottieDialog(
        onAnimated: () {
          Navigator.of(this, rootNavigator: true).pop();
          onAnimated();
        },
      ),
    );
  }

  void displayLoadingDialog({bool showOrHide = false}) {
    if (showOrHide) {
      showDialog(
        context: this,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: false,
        builder: (_) => const LoadingDialog(),
      );
    } else {
      Navigator.of(this, rootNavigator: true).pop();
    }
  }
}
