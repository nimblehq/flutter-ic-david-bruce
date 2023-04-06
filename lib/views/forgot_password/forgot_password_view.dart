import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/gen/assets.gen.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image(
            image: Assets.images.nimbleLogo.image().image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Logo overlay
          Positioned(
            top: 80.0,
            left: 20.0,
            child: Image(
              image: Assets.images.nimbleLogo.image().image,
              width: 150.0,
              height: 150.0,
            ),
          ),
          // Description overlay
          const Positioned(
            top: 250.0,
            left: 20.0,
            right: 20.0,
            child: Text(
              'Please enter your email address below and we will send you a link to reset your password.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Email text field overlay
          Positioned(
            top: 350.0,
            left: 20.0,
            right: 20.0,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          // Reset button overlay
          Positioned(
            top: 450.0,
            left: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Reset Password'),
            ),
          ),
        ],
      ),
    );
  }
}
