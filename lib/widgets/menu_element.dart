import 'package:flutter/material.dart';

class MenuElement extends StatelessWidget {
  final String icon;
  final String selectedIcon;
  final String label;

  const MenuElement({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Positioned(
        bottom: 2,
        child: Image.asset(
          "assets/images/$icon",
          height: 20,
        ),
      ),
      selectedIcon: Positioned(
        bottom: 2,
        child: Image.asset(
          "assets/images/$selectedIcon",
          height: 20,
        ),
      ),
      label: label,
    );
  }
}
