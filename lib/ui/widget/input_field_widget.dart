import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget({
    required this.textHint,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isPassword = false,
    this.textSuffixButton,
    this.textSuffixButtonCallback,
    super.key,
  });

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String textHint;
  final bool isPassword;
  final String? textSuffixButton;
  final VoidCallback? textSuffixButtonCallback;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusNormal)),
          hintText: textHint,
          filled: true,
          fillColor: Colors.white.withOpacity(0.18),
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingNormal,
            horizontal: Dimensions.paddingSmall,
          ),
          hintStyle: const TextStyle(
            color: Colors.white30,
          ),
          suffixIcon: textSuffixButton != null
              ? Padding(
                  padding:
                      const EdgeInsets.only(right: Dimensions.paddingSmallest),
                  child: TextButton(
                    onPressed: textSuffixButtonCallback != null
                        ? () => textSuffixButtonCallback!()
                        : () {},
                    child: Text(
                      textSuffixButton!,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Colors.white.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                )
              : null),
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
