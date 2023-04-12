import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/widget/input_field_widget.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';
import 'package:survey_flutter_ic/utils/custom_app_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPasswordScreen> {
  AppBar get _appBar => CustomAppBar.backButton(
        context: context,
        onPressed: () => context.go('/'),
      );

  Widget get _background => SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image(
        image: AssetImage(Assets.images.bgLoginOverlay.path),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ));

  Widget get _nimbleLogo => Padding(
      padding: const EdgeInsets.only(left: 104.0, right: 104.0),
      child: Image.asset(
        Assets.images.icNimbleWhiteLogo.path,
        fit: BoxFit.fitWidth,
      ));

  Widget _forgotPasswordInstruction(BuildContext context) => Text(
        AppLocalizations.of(context)!.forgotPasswordInstruction,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white70),
        textAlign: TextAlign.center,
      );

  InputFieldWidget get _emailTextField => InputFieldWidget(
        key: const Key('forgot_password_email'),
        textHint: AppLocalizations.of(context)!.loginEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );

  ElevatedButton get _resetButton => ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(Dimensions.buttonHeight),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusNormal),
          ),
        ),
        child: Text(AppLocalizations.of(context)!.forgotPasswordResetButton),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background,
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _nimbleLogo,
                  const SizedBox(height: Dimensions.paddingLarge),
                  _forgotPasswordInstruction(context),
                  const SizedBox(height: 96.0),
                  _emailTextField,
                  const SizedBox(height: Dimensions.paddingMedium),
                  _resetButton
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
