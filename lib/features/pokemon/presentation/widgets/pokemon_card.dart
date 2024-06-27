import 'package:flutter/material.dart';
import 'package:myapp/features/pokemon/domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(pokemon.image), Text(pokemon.name)
        ],
      ),
    );
  }
}