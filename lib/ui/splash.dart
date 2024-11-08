import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/services/dio.dart';
import 'package:flutter_pokedex/services/hive.dart';
import 'package:flutter_pokedex/themes/poke_theme.dart';
import 'package:flutter_pokedex/ui/start.dart';
import 'package:lottie/lottie.dart';
import '../models/pokemon.dart';
import '../other/global_variables.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final DioInstance _dioInstance = DioInstance();
  final HiveInstance _hiveManager = HiveInstance();

  final ValueNotifier<String> _downloadProgress = ValueNotifier("");

  Future downloadAllPokemon() async {
    int count = 0;

    // TODO: Improve performance
    try {
      Response getAllPokemonResponse = await _dioInstance.fetchAllPokemon();
      if (getAllPokemonResponse.statusCode == 200) {
        Pokemons pokemons = Pokemons.fromJson(getAllPokemonResponse.data);
        pokemonsList = await _hiveManager.getAllPokemons();
        if (pokemons.results != null) {
          if (pokemons.results!.length != pokemonsList.length) {
            for (var pokemon in pokemons.results!) {
              if (pokemon.name != null) {
                Response getSinglePokemonResponse = await _dioInstance.fetchSinglePokemon(pokemon.name!);
                var singlePokemonData = getSinglePokemonResponse.data;

                List<String> moves = [];
                for (var move in singlePokemonData['moves']) {
                  moves.add(move['move']['name']);
                }

                List<String> types = [];
                for (var type in singlePokemonData['types']) {
                  types.add(type['type']['name']);
                }

                Map<String, dynamic> singlePokemon = {
                  "id": singlePokemonData['id'],
                  "name": singlePokemonData['name'],
                  "height": singlePokemonData['height'],
                  "weight": singlePokemonData['weight'],
                  "moves": moves,
                  "types": types,
                  "urlImage": singlePokemonData['sprites']['front_default'],
                  "urlImageOfficial": singlePokemonData['sprites']['other']['official-artwork']['front_default']
                };
                await _hiveManager.write(key: pokemon.name!, value: jsonEncode(singlePokemon));

                count++;

                _downloadProgress.value = "Downloading all Pokémon informations.\nGrab a coffe, this is gonna take a while.\n\n$count / ${pokemons.results!.length}";

              } else {
                if (mounted) PokeTheme.snackBar(context, "Returned singlePokemon name is null");
              }
            }
          }
        } else {
          if (mounted) PokeTheme.snackBar(context, "Returned Pokemons values are null");
        }
      } else {
        if (mounted) PokeTheme.snackBar(context, "Failed to fetch all Pokémon from PokeAPI");
      }

      pokemonsList = await _hiveManager.getAllPokemons();

      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => const Start()));
      });
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      downloadAllPokemon();
    }
  }

  @override
  void initState() {
    super.initState();
    downloadAllPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokeTheme.red,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/loading.json", width: 200),
            const SizedBox(
              height: 16,
            ),
            ValueListenableBuilder(
              valueListenable: _downloadProgress,
              builder: (BuildContext context, value, Widget? child) {
                return Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.amber
                  ),
                  textAlign: TextAlign.center,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
