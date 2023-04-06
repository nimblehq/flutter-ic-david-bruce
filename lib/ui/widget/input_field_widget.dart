import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    required this.textHint,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isPassword = false,
    super.key,
  });

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String textHint;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusNormal)),
        hintText: textHint,
        filled: true,
        fillColor: Colors.white.withOpacity(0.18),
        contentPadding: const EdgeInsets.only(
          top: Dimensions.paddingNormal,
          bottom: Dimensions.paddingNormal,
          left: Dimensions.paddingSmall,
          right: Dimensions.paddingSmall,
        ),
        hintStyle: const TextStyle(
          color: Colors.white30,
        ),
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
      cursorColor: Colors.white,
      textInputAction: textInputAction,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}