import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:pokemon/consts/consts_api.dart';
import 'package:pokemon/models/pokeapi.dart';
import 'package:pokemon/stores/pokeapi_store.dart';

class PokeDetailPage extends StatelessWidget {
  final int index;

  const PokeDetailPage({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon _pokemon = _pokemonStore.getPokemon(index: this.index);

    return Scaffold(
      appBar: AppBar(
        title: Opacity(
          opacity: 0.0,
          child: Text(
            _pokemon.name,
            style: TextStyle(
              fontFamily: 'Google',
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: ConstsAPI.getColorType(type: _pokemon.type[0]),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      //backgroundColor: ConstsAPI.getColorType(type: _pokemon.type[0]),
      body: Stack(
        children: [
          Observer(builder: (context) {
            return Container(color: _pokemonStore.corPokemoAtual as Color);
          }),
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SlidingSheet(
            elevation: 8,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              // This is the content of the sheet that will get
              // scrolled, if the content is bigger than the available
              // height of the sheet.
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          Padding(
              padding: EdgeInsets.only(top: 50),
              child: SizedBox(
                height: 150,
                child: PageView.builder(
                  itemCount: _pokemonStore.pokeApi.pokemon.length,
                  itemBuilder: (BuildContext context, int count) {
                    Pokemon pokeItem = _pokemonStore.getPokemon(index: count);
                    return CachedNetworkImage(
                        height: 60,
                        width: 60,
                        imageUrl:
                            'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${pokeItem.num}.png');
                  },
                ),
              ))
        ],
      ),
    );
  }
}
