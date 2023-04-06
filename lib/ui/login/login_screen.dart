import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/widget/input_field_widget.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingLarge),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 109.0, left: 104.0, right: 104.0),
                      child: Image.asset(
                        Assets.images.icNimbleWhiteLogo.path,
                      )),
                  const Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.paddingMedium),
                      child: InputFieldWidget(
                        key: Key('login_email'),
                        textHint: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      )),
                  const Padding(
                      padding: EdgeInsets.only(bottom: Dimensions.paddingMedium),
                      child: InputFieldWidget(
                        key: Key('login_password'),
                        textHint: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                      )),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(Dimensions.buttonHeight),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radiusNormal),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
