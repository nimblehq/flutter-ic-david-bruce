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

  Widget get _nimbleLogo => Image(
        image: Assets.images.icNimbleWhiteLogo.image().image,
        width: 168.0,
        height: 40.0,
      );

  Widget _forgotPasswordInstruction(BuildContext context) => Text(
        AppLocalizations.of(context)!.forgotPasswordInstruction,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.white70),
        textAlign: TextAlign.center,
      );

  Widget get _emailTextField => const InputFieldWidget(
        key: Key('login_email'),
        textHint: 'Email',
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
                  const SizedBox(height: 20),
                  _forgotPasswordInstruction(context),
                  const SizedBox(height: 100),
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
