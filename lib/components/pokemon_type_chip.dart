import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonTypeChip extends StatelessWidget {
  final String tipo;
  final Color color;

  const PokemonTypeChip({super.key, required this.tipo, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tipo.toUpperCase(),
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
