import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:myapp/core/error/failure..dart';
import 'package:myapp/features/pokemon/data/datasource/pokemons_local_datasource.dart';
import 'package:myapp/features/pokemon/data/datasource/pokemons_remote_datasource.dart';

import 'package:myapp/features/pokemon/domain/entities/pokemon.dart';
import 'package:myapp/features/pokemon/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository{

  final PokemonLocalDataSource pokemonLocalDataSource;
  final PokemonRemoteDatasource pokemonRemoteDataSource;

  PokemonRepositoryImpl({required this.pokemonLocalDataSource, required this.pokemonRemoteDataSource});

  @override
  Future<Either<Failure, bool>> capturePokemon(Pokemon pokemon) async {
    try {
      final bool resp = await pokemonLocalDataSource.capturePokemon(pokemon);
      return Right(resp);
    } on LocalFailure {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getCapturePokemons() async {
    try {
      final List<Pokemon> resp = await pokemonLocalDataSource.getCapturedsPokemonList();
      return Right(resp);
    } on LocalFailure {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(int id) async {
    try {
      final Pokemon resp = await pokemonRemoteDataSource.getPokemon(id);
      return Right(resp);
    } on DioException {
      return Left(ServerFailure());
    }

  }
  
}