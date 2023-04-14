import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/ui_helper.dart';
import 'package:flutter_pokedex/model/pokemon_model.dart';

class PokeImageAndBall extends StatelessWidget {
  final PokemonModel pokemon;
  const PokeImageAndBall({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pokeballImageUrl = "assets/images/pokeball.png";
    return Align(
      alignment: Alignment.bottomRight,
      child: Stack(
        children: [
          Image.asset(
            pokeballImageUrl,
            width: UIHelper.calculatePokeImgAndBallSize(),
            height: UIHelper.calculatePokeImgAndBallSize(),
            fit: BoxFit.fitHeight,
          ),
          Hero(
            tag: pokemon.id!,
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => const Icon(Icons.ac_unit),
              imageUrl: pokemon.img ?? "",
              width: UIHelper.calculatePokeImgAndBallSize(),
              height: UIHelper.calculatePokeImgAndBallSize(),
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => CircularProgressIndicator(
                color: UIHelper.getColorFromType(pokemon.type![0]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
