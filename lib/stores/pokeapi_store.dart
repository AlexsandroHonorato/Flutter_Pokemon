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
  PokeApi get pokeApi => _pokeApi;

  @action
  fetchPokemonList() {
    _pokeApi = null;
    loadPokeAPI().then((pokeList) {
      _pokeApi = pokeList;
      print(_pokeApi.toString());
    });
  }

  @action
  getPokemon({int index}) {
    return _pokeApi.pokemon[index];
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

  Color getColorType({String type}) {
    switch (type) {
      case 'Normal':
        return Colors.brown[400];
        break;
      case 'Fire':
        return Colors.red;
        break;
      case 'Water':
        return Colors.blue;
        break;
      case 'Grass':
        return Colors.green;
        break;
      case 'Electric':
        return Colors.amber;
        break;
      case 'Ice':
        return Colors.cyanAccent[400];
        break;
      case 'Fighting':
        return Colors.orange;
        break;
      case 'Poison':
        return Colors.purple;
        break;
      case 'Ground':
        return Colors.orange[300];
        break;
      case 'Flying':
        return Colors.indigo[200];
        break;
      case 'Psychic':
        return Colors.pink;
        break;
      case 'Bug':
        return Colors.lightGreen[500];
        break;
      case 'Rock':
        return Colors.grey;
        break;
      case 'Ghost':
        return Colors.indigo[400];
        break;
      case 'Dark':
        return Colors.brown;
        break;
      case 'Dragon':
        return Colors.indigo[800];
        break;
      case 'Steel':
        return Colors.blueGrey;
        break;
      case 'Fairy':
        return Colors.pinkAccent[100];
        break;
      default:
        return Colors.grey;
        break;
    }
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
