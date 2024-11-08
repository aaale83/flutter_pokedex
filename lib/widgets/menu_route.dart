import 'package:flutter/material.dart';

class MenuRoute extends StatelessWidget {
  final Key? navigatorState;
  final Widget page;

  const MenuRoute({
    super.key,
    required this.navigatorState,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Navigator(
        key: navigatorState,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                return page;
              }
          );
        },
      ),
    );
  }
}
