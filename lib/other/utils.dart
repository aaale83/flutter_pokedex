import 'dart:ui';

import 'package:flutter_pokedex/themes/poke_theme.dart';

class Utils {

  String capitalize(String string) {
    return "${string[0].toUpperCase()}${string.substring(1)}";
  }

  Color? chipColor(String mainType) {
    Color? color;
    switch (mainType) {
      case "normal":
        color = PokeTheme.normal;
        break;
      case "fire":
        color = PokeTheme.fire;
        break;
      case "water":
        color = PokeTheme.water;
        break;
      case "electric":
        color = PokeTheme.electric;
        break;
      case "grass":
        color = PokeTheme.grass;
        break;
      case "ice":
        color = PokeTheme.ice;
        break;
      case "fighting":
        color = PokeTheme.fighting;
        break;
      case "poison":
        color = PokeTheme.poison;
        break;
      case "ground":
        color = PokeTheme.ground;
        break;
      case "flying":
        color = PokeTheme.flying;
        break;
      case "psychic":
        color = PokeTheme.psychic;
        break;
      case "bug":
        color = PokeTheme.bug;
        break;
      case "rock":
        color = PokeTheme.rock;
        break;
      case "ghost":
        color = PokeTheme.ghost;
        break;
      case "dragon":
        color = PokeTheme.dragon;
        break;
      case "dark":
        color = PokeTheme.dark;
        break;
      case "steel":
        color = PokeTheme.steel;
        break;
      case "fairy":
        color = PokeTheme.fairy;
        break;
    }
    return color;
  }

}