import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/utils/dimension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingLarge,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Home screen')],
          ),
        ),
      ),
    );
  }
}
