import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          alignment: FractionalOffset.center,
          height: 100,
          padding: const EdgeInsets.all(20),
          child: const SizedBox(
            width: 80,
            height: 80,
            child: FittedBox(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
