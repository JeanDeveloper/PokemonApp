import 'package:dio/dio.dart';
import 'package:myapp/features/pokemon/data/models/pokemon_model.dart';

abstract class PokemonRemoteDatasource{
  Future<PokemonModel> getPokemon(int id);
}


class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource{
  
  final Dio dio = Dio();
  
  @override
  Future<PokemonModel> getPokemon(int id) async {

    final resp = await dio.get('https://pokeapi.co/api/v2/pokemon/$id/');

    return PokemonModel.fromJson(resp.data);


  }
}