import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/login/login_state.dart';
import 'package:survey_flutter_ic/ui/login/login_view_model.dart';
import 'package:survey_flutter_ic/ui/widget/input_field_widget.dart';
import 'package:survey_flutter_ic/usecases/login_use_case.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>(
  (_) => LoginViewModel(getIt.get<LoginUseCase>()),
);

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  Image get _backgroundImage => Image(
        image: AssetImage(Assets.images.bgLoginOverlay.path),
        fit: BoxFit.fill,
      );

  Padding get _nimbleLogoImage => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 104.0),
      child: Image.asset(
        Assets.images.icNimbleWhiteLogo.path,
        fit: BoxFit.fitWidth,
      ));

  InputFieldWidget get _emailInputField => InputFieldWidget(
        key: const Key('login_email'),
        textHint: context.localization.loginEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: _emailInputController,
      );

  InputFieldWidget get _passwordInputField => InputFieldWidget(
        key: const Key('login_password'),
        textHint: context.localization.loginPassword,
        keyboardType: TextInputType.visiblePassword,
        isPassword: true,
        textSuffixButton: context.localization.loginForgotPassword,
        textSuffixButtonCallback: () => context.go('/forgotPassword'),
        controller: _passwordInputController,
      );

  ElevatedButton get _loginButton => ElevatedButton(
        onPressed: () {
          ref.read(loginViewModelProvider.notifier).login(
                _emailInputController.text,
                _passwordInputController.text,
              );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(Dimensions.buttonHeight),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusNormal),
          ),
        ),
        child: Text(
          context.localization.login,
          style: context.textTheme.titleSmall?.copyWith(color: Colors.black),
        ),
      );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark));
    _registerStateListener();
    return Stack(
      fit: StackFit.expand,
      children: [
        _backgroundImage,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingLarge),
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
        ),
      ],
    );
  }

  void _registerStateListener() {
    ref.listen<LoginState>(loginViewModelProvider, (_, state) {
      context.displayLoadingIndicator(
        showOrHide: state == const LoginState.loading(),
      );
      state.maybeWhen(
        success: () => context.go('/home'),
        error: (errorMessage) => context.showMessageSnackBar(
          message: errorMessage,
        ),
        errorEmailInput: () => context.showMessageSnackBar(
          message: context.localization.messageEmailInvalid,
        ),
        errorPasswordInput: () => context.showMessageSnackBar(
          message: context.localization.messagePasswordInvalid,
        ),
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }
}
