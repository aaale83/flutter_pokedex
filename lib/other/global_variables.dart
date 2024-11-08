import 'package:flutter/material.dart';
import '../models/single_pokemon.dart';

double screenWidth = 0;
double screenHeight = 0;
BuildContext? originalContext; // TODO: Avoid buildcontext as global variable
List<SinglePokemon> pokemonsList = [];