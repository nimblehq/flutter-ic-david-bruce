import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void showMessageSnackBar({required String message}) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
}
