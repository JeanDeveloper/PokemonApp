import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/core/error/failure..dart';
import 'package:myapp/features/pokemon/data/models/pokemon_model.dart';
import 'package:myapp/features/pokemon/domain/entities/pokemon.dart';

abstract class PokemonLocalDataSource{
  Future<bool> capturePokemon(Pokemon pokemon);
  Future<List<PokemonModel>> getCapturedsPokemonList();
}


class HivePokemonLocalDatasourceImpl implements PokemonLocalDataSource{

  HivePokemonLocalDatasourceImpl(){
    Hive.initFlutter();
  }


  @override
  Future<bool> capturePokemon(Pokemon pokemon) async {
    try {

      Box<dynamic> box = await Hive.openBox('pokemons');

      box.put(pokemon.id, PokemonModel.fromEntity(pokemon).toJson());

      return true;
      
    } catch (error) {

      debugPrint(error.toString());
      throw LocalFailure();
      
    }
  }

  @override
  Future<List<PokemonModel>> getCapturedsPokemonList() async {
    try {

      Box<dynamic> box = await Hive.openBox('pokemons');

      return box.values.map((p) => PokemonModel.fromJson(p)).toList();
      
    } catch (error) {
      debugPrint(error.toString());
      throw LocalFailure();
    }

  }

}