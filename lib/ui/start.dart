import 'package:flutter/material.dart';
import 'package:flutter_pokedex/ui/pokeai.dart';
import 'package:flutter_pokedex/ui/pokesearch.dart';
import '../other/global_variables.dart';
import '../widgets/menu_element.dart';
import '../widgets/menu_route.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {

  Map<int, GlobalKey<NavigatorState>> navigatorState = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
  };

  int currentTab = 0;

  @override
  Widget build(BuildContext context) {

    originalContext = context;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: IndexedStack(
          index: currentTab,
          children: [
            MenuRoute(navigatorState: navigatorState[0], page: const PokeSearch()),
            MenuRoute(navigatorState: navigatorState[1], page: const PokeAI()),
          ],
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: currentTab,
            onDestinationSelected: (int index) {
              if (index != currentTab) {
                setState(() {
                  currentTab = index;
                });
              } else {
                var currentContext = navigatorState[index]?.currentContext;
                if (currentContext != null) {
                  Navigator.of(currentContext).popUntil((route) => route.isFirst);
                }
              }
            },
            destinations: const [
              MenuElement(icon: "search.png", selectedIcon: "search.png", label: "Pokésearch"),
              MenuElement(icon: "gemini.png", selectedIcon: "gemini.png", label: "PokéAI"),
            ]
        ),
      ),
    );
  }
}
