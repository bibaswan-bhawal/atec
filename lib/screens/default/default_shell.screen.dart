import 'package:atec/router/routes.dart';
import 'package:flutter/material.dart';

import 'package:atec/theme/theme.dart';

/// Default Shell Screen to allow for a bottom navigation bar
class DefaultShellScreen extends StatefulWidget {
  const DefaultShellScreen({super.key, required this.navigator});

  final Widget navigator;

  @override
  State<DefaultShellScreen> createState() => _DefaultShellScreenState();
}

class _DefaultShellScreenState extends State<DefaultShellScreen> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        const HomeRoute().go(context);
      case 1:
        const PatientsRoute().go(context);
      default:
        const HomeRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme.setSystemUIDark();

    return Scaffold(
      body: widget.navigator,
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        selectedIndex: _selectedIndex,
        indicatorColor: AppColors.gray[200],
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          NavigationDestination(icon: AppIcons.home_gray, selectedIcon: AppIcons.home_dark, label: 'Home'),
          NavigationDestination(icon: AppIcons.book_gray, selectedIcon: AppIcons.book_dark, label: 'Patients'),
        ],
      ),
    );
  }
}
