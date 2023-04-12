import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/widget/input_field_widget.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  Padding get _nimbleLogoImage => Padding(
      padding: const EdgeInsets.only(left: 104.0, right: 104.0),
      child: Image.asset(
        Assets.images.icNimbleWhiteLogo.path,
        fit: BoxFit.fitWidth,
      ));

  InputFieldWidget get _emailInputField => InputFieldWidget(
        key: const Key('login_email'),
        textHint: AppLocalizations.of(context)!.loginEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );

  InputFieldWidget get _passwordInputField => InputFieldWidget(
      key: const Key('login_password'),
      textHint: AppLocalizations.of(context)!.loginPassword,
      keyboardType: TextInputType.visiblePassword,
      isPassword: true,
      textSuffixButton: AppLocalizations.of(context)!.loginForgotPassword,
      textSuffixButtonCallback: null);

  ElevatedButton get _loginButton => ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(Dimensions.buttonHeight),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusNormal),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.login,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.black),
        ),
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.images.bgLoginOverlay.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.paddingLarge),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _nimbleLogoImage,
                  const SizedBox(height: 109),
                  _emailInputField,
                  const SizedBox(height: Dimensions.paddingMedium),
                  _passwordInputField,
                  const SizedBox(height: Dimensions.paddingMedium),
                  _loginButton,
                ],
              ),
            ),
          ),
        ));
  }
}
