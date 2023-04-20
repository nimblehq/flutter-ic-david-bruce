import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey_flutter_ic/ui/widget/loading_dialog.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  void showMessageSnackBar({required String message}) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));

  void displayLoadingIndicator({bool showOrHide = false}) {
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
