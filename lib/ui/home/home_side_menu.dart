import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu_component_id.dart';
import 'package:survey_flutter_ic/ui/home/home_side_menu_ui_model.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';

class SideMenu extends StatelessWidget {
  final SideMenuUIModel sideMenuUIModel;
  final VoidCallback? logoutCallback;

  const SideMenu({
    super.key,
    required this.sideMenuUIModel,
    required this.logoutCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: const Color(0xFF1E1E1E),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Row(
                      children: [
                        _userProfileName(context),
                        _userProfileAvatar(),
                      ],
                    ),
                  ),
                  _divider(),
                  _logOut(context),
                ],
              ),
            ),
            _appVersion(context),
          ],
        ));
  }

  ListTile _appVersion(BuildContext context) {
    return ListTile(
      title: Text(
        sideMenuUIModel.version,
        style: context.textTheme.bodySmall?.copyWith(color: Colors.white70),
      ),
    );
  }

  ListTile _logOut(BuildContext context) {
    return ListTile(
      key: HomeSideMenuComponentId.logoutButton,
      title: Text(
        context.localization.logout,
        style: context.textTheme.bodyLarge?.copyWith(color: Colors.white70),
      ),
      onTap: logoutCallback,
    );
  }

  Padding _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(
        color: Colors.white70,
      ),
    );
  }

  CircleAvatar _userProfileAvatar() {
    return const CircleAvatar(
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        size: 36.0,
        color: Colors.white,
      ),
    );
  }

  Expanded _userProfileName(BuildContext context) {
    return Expanded(
      child: Text(
        sideMenuUIModel.name,
        style: context.textTheme.headlineLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
