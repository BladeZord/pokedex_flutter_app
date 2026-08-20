import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_flutter_app/models/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  final VoidCallback onTap;

  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                pokemon.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.catching_pokemon),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                pokemon.name.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
