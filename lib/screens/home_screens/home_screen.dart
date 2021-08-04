import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:pokemon/consts/consts_app.dart';
import 'package:pokemon/models/pokeapi.dart';
import 'package:pokemon/screens/home_screens/widgets/app_bar_home.dart';
import 'package:pokemon/screens/home_screens/widgets/poke_item.dart';
import 'package:pokemon/screens/poke_detail/poke_details_screens.dart';
import 'package:pokemon/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PokeApiStore _pokemonStore = Provider.of<PokeApiStore>(context);
    if (_pokemonStore.pokeApi == null) {
      _pokemonStore.fetchPokemonList();
    }

    double screenWidht = MediaQuery.of(context).size.width;
    double statusWidht = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -(240 / 4.7),
            left: screenWidht - (240 / 1.6),
            child: Opacity(
              child: Image.asset(
                ConstsApp.blackPokeball,
                height: 240,
                width: 240,
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  height: statusWidht,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: Observer(
                      builder: (BuildContext context) {
                        return (_pokemonStore.pokeApi != null)
                            ? AnimationLimiter(
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(12),
                                  addAutomaticKeepAlives: true,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount:
                                      _pokemonStore.pokeApi.pokemon.length,
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon =
                                        _pokemonStore.getPokemon(index: index);
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: GestureDetector(
                                          child: PokeItem(
                                            types: pokemon.type,
                                            index: index,
                                            name: pokemon.name,
                                            num: pokemon.num,
                                          ),
                                          onTap: () {
                                            _pokemonStore.setPokemonAtual(
                                                index: index);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PokeDetailPage(
                                                              index: index),
                                                  fullscreenDialog: true,
                                                ));
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
