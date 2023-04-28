import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter_ic/di/di.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_state.dart';
import 'package:survey_flutter_ic/ui/forgot_password/forgot_password_view_model.dart';
import 'package:survey_flutter_ic/ui/widget/input_field_widget.dart';
import 'package:survey_flutter_ic/usecases/forgot_password_use_case.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/custom_app_bar.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';
import 'package:survey_flutter_ic/utils/route_path.dart';

final forgotPasswordViewModelProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordViewModel, ForgotPasswordState>(
  (_) => ForgotPasswordViewModel(getIt.get<ForgotPasswordUseCase>()),
);

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailInputController = TextEditingController();

  AppBar get _appBar => CustomAppBar.backButton(
        context: context,
        onPressed: null,
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
      padding: const EdgeInsets.symmetric(horizontal: 104.0),
      child: Image.asset(
        Assets.images.icNimbleWhiteLogo.path,
        fit: BoxFit.fitWidth,
      ));

  Widget _forgotPasswordInstruction(BuildContext context) => Text(
        context.localization.forgotPasswordInstruction,
        style: context.textTheme.bodyLarge?.copyWith(color: Colors.white70),
        textAlign: TextAlign.center,
      );

  InputFieldWidget get _emailInputField => InputFieldWidget(
        key: const Key('forgot_password_email'),
        textHint: context.localization.loginEmail,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: _emailInputController,
      );

  ElevatedButton get _resetButton => ElevatedButton(
        onPressed: () {
          ref.read(forgotPasswordViewModelProvider.notifier).forgotPassword(
                _emailInputController.text,
              );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(Dimensions.buttonHeight),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusNormal),
          ),
        ),
        child: Text(context.localization.forgotPasswordResetButton),
      );

  @override
  Widget build(BuildContext context) {
    _registerStateListener();
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
                  _emailInputField,
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

  void _registerStateListener() {
    ref.listen<ForgotPasswordState>(forgotPasswordViewModelProvider,
        (_, state) {
      context.displayLoadingDialog(
        showOrHide: state == const ForgotPasswordState.loading(),
      );
      state.maybeWhen(
        success: (message) => context.showMessageSnackBar(
          message: message,
        ),
        error: (errorMessage) => context.showMessageSnackBar(
          message: errorMessage,
        ),
        errorEmailInput: () => context.showMessageSnackBar(
          message: context.localization.messageEmailInvalid,
        ),
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    super.dispose();
  }
}
