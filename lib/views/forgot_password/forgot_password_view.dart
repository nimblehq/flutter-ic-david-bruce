import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildForgotPasswordView();
  }

  Widget _buildForgotPasswordView() {
    return Stack(
      children: [
        Image(
          image: Assets.images.nimbleBackground.image().image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              child: Column(
                children: [],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
