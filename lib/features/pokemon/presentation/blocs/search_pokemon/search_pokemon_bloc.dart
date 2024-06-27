import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/core/error/failure..dart';
import 'package:myapp/features/pokemon/domain/entities/pokemon.dart';
import 'package:myapp/features/pokemon/domain/usecases/capture_pokemon.dart';
import 'package:myapp/features/pokemon/domain/usecases/get_captured_pokemons.dart';
import 'package:myapp/features/pokemon/domain/usecases/search_pokemon.dart';

import 'package:myapp/core/utils/utils.dart' as utils;

part 'search_pokemon_event.dart';
part 'search_pokemon_state.dart';

class SearchPokemonBloc extends Bloc<SearchPokemonEvent, SearchPokemonState> {

  final CapturePokemonUseCase _capturePokemonUseCase;
  final GetCapturedPokemonsUseCase _getCapturedsPokemonsUseCase;
  final SearchPokemonUseCase _searchPokemonUseCase;

  SearchPokemonBloc(
    this._capturePokemonUseCase, 
    this._getCapturedsPokemonsUseCase, 
    this._searchPokemonUseCase
  ) : super(SearchPokemonInitial()) {

    on<SearchPokemonEvent>((event, emit) async {

      if(event is OnSearchPokemon){
        emit(SearchPokemonLoading());
        final resp  = await _searchPokemonUseCase(utils.randomPokemonId);
        resp.fold(
          (f) => emit(SearchPokemonFailure(failure:f)), 
          (p) => emit(SearchPokemonSuccess(pokemon: p)) 
        ); 
      }

      if(event is OnCapturePokemon){
        final resp = await _capturePokemonUseCase(event.pokemon);
        resp.fold((f) => emit(SearchPokemonFailure(failure: f)), (p){});
      }

      if(event is OnGetCapturedPokemons){
        final resp = await _getCapturedsPokemonsUseCase();
        resp.fold((f) => emit(SearchPokemonFailure(failure: f)), (ps) => emit(SearchPokemonList(pokemons: ps)));
      }
     
    });

  }

}
