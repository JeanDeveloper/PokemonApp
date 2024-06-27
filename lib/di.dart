

import 'package:get_it/get_it.dart';
import 'package:myapp/features/pokemon/data/datasource/pokemons_local_datasource.dart';
import 'package:myapp/features/pokemon/data/datasource/pokemons_remote_datasource.dart';
import 'package:myapp/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:myapp/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:myapp/features/pokemon/domain/usecases/capture_pokemon.dart';
import 'package:myapp/features/pokemon/domain/usecases/get_captured_pokemons.dart';
import 'package:myapp/features/pokemon/domain/usecases/search_pokemon.dart';
import 'package:myapp/features/pokemon/presentation/blocs/search_pokemon/search_pokemon_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {

  //bloc
  di.registerFactory(()=> SearchPokemonBloc(
    di(), 
    di(), 
    di()
  ));

  //Use Cases
  di.registerFactory(() => CapturePokemonUseCase(repository: di()));
  di.registerFactory(() => GetCapturedPokemonsUseCase(repository: di()));
  di.registerFactory(() => SearchPokemonUseCase(repository: di()));

  //Repository
  di.registerFactory<PokemonRepository>(() => PokemonRepositoryImpl(
    pokemonLocalDataSource: di(), 
    pokemonRemoteDataSource: di()
  ));

  //DataSource

  di.registerFactory<PokemonLocalDataSource>(() => HivePokemonLocalDatasourceImpl());
  di.registerFactory<PokemonRemoteDatasource>(() => PokemonRemoteDatasourceImpl());

}