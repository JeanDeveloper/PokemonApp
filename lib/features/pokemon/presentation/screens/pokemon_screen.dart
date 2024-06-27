import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/pokemon/presentation/blocs/search_pokemon/search_pokemon_bloc.dart';
import 'package:myapp/features/pokemon/presentation/widgets/pokemon_card.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<SearchPokemonBloc, SearchPokemonState>(
        builder: (context, state){
          switch (state) {

            case SearchPokemonLoading():
              return const Center(child: CircularProgressIndicator());

            case SearchPokemonInitial():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => BlocProvider.of<SearchPokemonBloc>(context).add(OnSearchPokemon()), 
                      child: const Text("Generar Pokemon aleatorio")
                    ),
                    SizedBox(height: size.height * .05),
                    OutlinedButton(
                      onPressed: () => BlocProvider.of<SearchPokemonBloc>(context).add(OnGetCapturedPokemons()), 
                      child: const Text("Ver mis pokemones capturados")
                    )
                  ],
                ),
              );

            case SearchPokemonSuccess():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PokemonCard(pokemon: state.pokemon),
                    SizedBox(height: size.height * .05),
                    OutlinedButton(
                      onPressed: () => BlocProvider.of<SearchPokemonBloc>(context).add(OnSearchPokemon()), 
                      child: const Text("Generar Otro Pokemon aleatorio")
                    ),
                    SizedBox(height: size.height * .05),
                    OutlinedButton(
                      onPressed: () => BlocProvider.of<SearchPokemonBloc>(context).add(OnGetCapturedPokemons()), 
                      child: const Text("Ver mis pokemones capturados")
                    ),
                    SizedBox(height: size.height * .05),
                    OutlinedButton(
                      onPressed: () => BlocProvider.of<SearchPokemonBloc>(context).add(OnCapturePokemon(pokemon: state.pokemon)), 
                      child: Text("Capturar a ${state.pokemon.name}")
                    )
                  ],
                ),
              );

            case SearchPokemonList():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: state.pokemons.map((p) => PokemonCard(pokemon: p)).toList(),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => BlocProvider.of<SearchPokemonBloc>(context).add(OnSearchPokemon()), 
                      child: const Text("Volver y Generar Pokemon")
                    ),
                  ],
                ),
              );

            case SearchPokemonFailure():
              return Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Ha ocurrido un error, que te parece si lo intentamos de nuevo?"),
                    OutlinedButton(
                      onPressed: () => BlocProvider.of<SearchPokemonBloc>(context).add(OnSearchPokemon()), 
                      child: const Text("Volver y Generar Pokemon")
                    ),
                  ],
                ),
              );

            default: 
             return const Center(child: CircularProgressIndicator());

          }

        },
      ),

    );

  }
}