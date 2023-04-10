import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/widget/input_field_widget.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: Assets.images.icNimbleWhiteLogo.image().image,
                          width: 168.0,
                          height: 40.0,
                        ),
                        const SizedBox(height: 24.0),
                        Text(
                          AppLocalizations.of(context)!
                              .forgotPasswordInstruction,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 100.0),
                      ]),
                  const Padding(
                      padding:
                          EdgeInsets.only(bottom: Dimensions.paddingMedium),
                      child: InputFieldWidget(
                        key: Key('login_email'),
                        textHint: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          const Size.fromHeight(Dimensions.buttonHeight),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusNormal),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.forgotPasswordResetButton,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
