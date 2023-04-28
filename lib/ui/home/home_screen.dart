import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu_ui_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      endDrawer: SideMenu(
        sideMenuUIModel: SideMenuUIModel(
          name: 'Mai',
          version: 'v0.1.0 (1562903885)',
        ),
      ),
      body: const Center(
        child: Text('Welcome to Home Screen!'),
      ),
    );
  }
}
