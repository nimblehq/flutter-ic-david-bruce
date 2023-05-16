import 'package:flutter/material.dart';

import '../../../utils/dimension.dart';

InputDecoration inputDecoration({
  required String hintText,
}) {
  return InputDecoration(
    labelText: hintText,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(Dimensions.radiusNormal),
    ),
    alignLabelWithHint: true,
    fillColor: Colors.white24,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(
      vertical: Dimensions.paddingSemi,
      horizontal: Dimensions.paddingSmall,
    ),
  );
}
