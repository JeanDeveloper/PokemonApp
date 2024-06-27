
import 'package:dartz/dartz.dart';
import 'package:myapp/core/error/failure..dart';
import 'package:myapp/features/pokemon/domain/entities/pokemon.dart';
import 'package:myapp/features/pokemon/domain/repositories/pokemon_repository.dart';

class SearchPokemonUseCase{
  
  final PokemonRepository repository;

  SearchPokemonUseCase({required this.repository});

  Future<Either<Failure,Pokemon>> call( int id ){
    return repository.getPokemon(id);
  }


}