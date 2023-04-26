import 'package:flutter/material.dart';
import 'package:survey_flutter_ic/utils/context_ext.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      endDrawer: Drawer(
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
                          Expanded(
                            child: Text(
                              'Mai',
                              style: context.textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              size: 36.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.white70,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Logout',
                        style: context.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white70),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ListTile(
                  title: Text(
                    'Version 1.0',
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: Colors.white70),
                  ),
                ),
              ),
            ],
          )),
      body: const Center(
        child: Text('Welcome to Home Screen!'),
      ),
    );
  }
}
