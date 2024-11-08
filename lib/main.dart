import 'package:flutter/material.dart';
import 'package:flutter_pokedex/other/global_variables.dart';
import 'package:flutter_pokedex/themes/poke_theme.dart';
import 'package:flutter_pokedex/ui/splash.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  runApp(
      const MaterialApp(
        home: PokeMain(),
        debugShowCheckedModeBanner: false,
      )
  );
}

class PokeMain extends StatefulWidget {
  const PokeMain({super.key});

  @override
  State<PokeMain> createState() => _PokeMainState();
}

class _PokeMainState extends State<PokeMain> {

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: PokeTheme.lightTheme,
        home: const Splash(),
      ),
    );
  }
}


