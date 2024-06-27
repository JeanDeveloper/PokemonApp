

import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failure..dart';
import 'package:myapp/features/pokemon/domain/entities/pokemon.dart';
import 'package:myapp/features/pokemon/domain/repositories/pokemon_repository.dart';

class CapturePokemonUseCase{
  
  final PokemonRepository repository;

  CapturePokemonUseCase({required this.repository});

  Future<Either<Failure,bool>> call(Pokemon pokemon){
    return repository.capturePokemon(pokemon);
  }


}