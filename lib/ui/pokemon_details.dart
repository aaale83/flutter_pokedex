import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/single_pokemon.dart';
import '../other/utils.dart';
import '../themes/poke_theme.dart';

class PokemonDetails extends StatelessWidget {
  final SinglePokemon singlePokemon;
  const PokemonDetails({
    super.key,
    required this.singlePokemon
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Utils().chipColor(singlePokemon.types![0])!.withAlpha(120),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 24),
              width: double.infinity,
              color: Utils().chipColor(singlePokemon.types![0])!.withAlpha(120),
              child: singlePokemon.urlImageOfficial != null ? CachedNetworkImage(
                width: 100,
                imageUrl: singlePokemon.urlImageOfficial!,
                errorWidget: (context, url, error) => Image.asset("assets/images/pokeball.png", width: 100),
              ) : Image.asset("assets/images/pokeball.png", width: 100),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Utils().capitalize(singlePokemon.name!),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 12.0,
                      children: singlePokemon.types!.asMap().entries.map((label) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Utils().chipColor(singlePokemon.types![label.key])
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
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(text: 'Weight: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "${singlePokemon.weight! / 10} kg"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(text: 'Height: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "${singlePokemon.height! / 10} mt"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Moves",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 12.0,
                      children: singlePokemon.moves!.asMap().entries.map((label) {
                        return Container(
                            padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Utils().chipColor(singlePokemon.types![0])
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
