import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:pokemon/consts/consts_api.dart';
import 'package:pokemon/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeApi _pokeApi;

  @observable
  dynamic _corPokemonAtual;

  @observable
  Pokemon pokemonAtual;

  @observable
  PokeApi get pokeApi => _pokeApi;

  @observable
  PokeApi get corPokemoAtual => _corPokemonAtual;

  @action
  fetchPokemonList() {
    _pokeApi = null;
    loadPokeAPI().then((pokeList) {
      _pokeApi = pokeList;
    });
  }

  @action
  getPokemon({int index}) {
    return _pokeApi.pokemon[index];
  }

  @action
  setPokemonAtual({int index}) {
    pokemonAtual = _pokeApi.pokemon[index];
    _corPokemonAtual = ConstsAPI.getColorType(type: pokemonAtual.type[0]);
  }

  @action
  Widget getImage({String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  Future<PokeApi> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeApi.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
