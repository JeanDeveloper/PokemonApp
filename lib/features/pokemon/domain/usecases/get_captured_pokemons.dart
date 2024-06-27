import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failure..dart';
import 'package:myapp/features/pokemon/domain/entities/pokemon.dart';
import 'package:myapp/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetCapturedPokemonsUseCase{
  final PokemonRepository repository;

  GetCapturedPokemonsUseCase({required this.repository});

  Future<Either<Failure,List<Pokemon>>> call(){
    return repository.getCapturePokemons();
  }
 

}