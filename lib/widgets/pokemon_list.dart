import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokemon_model.dart';
import 'package:flutter_pokedex/services/pokdex_api.dart';
import 'package:flutter_pokedex/widgets/pokelist_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late Future<List<PokemonModel>> _pokemonList;

  @override
  void initState() {
    super.initState();
    _pokemonList = PokeApi.getPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PokemonModel>>(
        future: _pokemonList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PokemonModel> _myList = snapshot.data!;
            return GridView.builder(
              itemCount: _myList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      ScreenUtil().orientation == Orientation.portrait ? 2 : 3),
              itemBuilder: (context, index) =>
                  PokeListItem(pokemon: _myList[index]),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Hata çıktı"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
