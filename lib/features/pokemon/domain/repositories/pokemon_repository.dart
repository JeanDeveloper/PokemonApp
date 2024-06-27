import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failure..dart';
import 'package:myapp/features/pokemon/domain/entities/pokemon.dart';

abstract class PokemonRepository {

  Future<Either<Failure,Pokemon>> getPokemon(int id);

  Future<Either<Failure,bool>> capturePokemon(Pokemon pokemon);

  Future<Either<Failure,List<Pokemon>>> getCapturePokemons();

}