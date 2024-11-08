import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/other/global_variables.dart';
import 'package:flutter_pokedex/themes/poke_theme.dart';
import 'package:flutter_pokedex/ui/pokemon_details.dart';
import 'package:flutter_pokedex/widgets/custom_loader_indicator.dart';
import 'package:lottie/lottie.dart';

import '../models/single_pokemon.dart';
import '../other/utils.dart';

class PokeSearch extends StatefulWidget {
  const PokeSearch({super.key,});

  @override
  State<PokeSearch> createState() => _PokeSearchState();
}

class _PokeSearchState extends State<PokeSearch> {

  final TextEditingController _searchTEC = TextEditingController();
  final FocusNode _searchFN = FocusNode();

  final ValueNotifier<bool> _isSearching = ValueNotifier(false);

  Timer? _timer;
  List<SinglePokemon> _filteredPokemonsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokédex",
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            height: 36,
            child: TextFormField(
              controller: _searchTEC,
              focusNode: _searchFN,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/search.png", color: Colors.black),
                )
              ),
              onChanged: (value) {
                _isSearching.value = true;
                if (_timer != null) {
                  _timer!.cancel();
                }

                _timer = Timer(const Duration(milliseconds: 600), () {
                  _isSearching.value = false;
                  _filteredPokemonsList = pokemonsList.where((singleValue) => singleValue.name!.toLowerCase().contains(value.toLowerCase())).toList();
                });
              },
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, value, Widget? child) {
            return value
              ? Center(child: CustomLoaderIndicator(color: PokeTheme.azure, radius: 16,))
              : _searchTEC.text == ""
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("assets/lottie/pokemon.json", width: 200),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text("Search for a Pokémon using\nthe top field", textAlign: TextAlign.center)
                ],
              )
              : _filteredPokemonsList.isEmpty
              ? SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      width: 200,
                      imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/54.png",
                      errorWidget: (context, url, error) => Image.asset("assets/images/pokeball.png", width: 100),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text("Psyaiaiaiii ... No results found"),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _filteredPokemonsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 190
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => PokemonDetails(singlePokemon: _filteredPokemonsList[index])));
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 44, 0, 0),
                            decoration: BoxDecoration(
                              color: Utils().chipColor(_filteredPokemonsList[index].types![0])!.withAlpha(120),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 8,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            height: 120,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Text(
                                    Utils().capitalize(_filteredPokemonsList[index].name!),
                                    style: _filteredPokemonsList[index].name!.length > 20 ? PokeTheme.lightTheme.textTheme.headlineSmall : PokeTheme.lightTheme.textTheme.headlineLarge,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    child: Wrap(
                                      spacing: 8.0,
                                      runSpacing: 12.0,
                                      children: _filteredPokemonsList[index].types!.asMap().entries.map((label) {
                                        return Container(
                                            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Utils().chipColor(_filteredPokemonsList[index].types![label.key])
                                            ),
                                            child: Text(
                                              Utils().capitalize(label.value),
                                              style: PokeTheme.lightTheme.textTheme.headlineSmall!.copyWith(
                                                  color: PokeTheme.white
                                              ),
                                            )
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            child: _filteredPokemonsList[index].urlImageOfficial != null ? CachedNetworkImage(
                              width: 100,
                              imageUrl: _filteredPokemonsList[index].urlImageOfficial!,
                              errorWidget: (context, url, error) => Image.asset("assets/images/pokeball.png", height: 80),
                            ) : Image.asset("assets/images/pokeball.png", height: 80),
                          ),
                        ],
                      ),
                    );
                  }
              ),
            );
          },
        ),
      ),
    );
  }
}
