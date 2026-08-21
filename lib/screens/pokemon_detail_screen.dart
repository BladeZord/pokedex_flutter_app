import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/constants/app_constants.dart';
import 'package:pokedex_flutter_app/helpers/color_helper.dart';
import '../components/pokemon_type_chip.dart';
import '../models/pokemon_model.dart';
import '../services/pokemon_service.dart';

class PokemonDetailScreen extends StatelessWidget {
  final PokemonModel pokemon;
  final PokemonService _service = PokemonService();

  PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final colorPrincipal = ColorHelper.colorPorTipo(pokemon.types.first);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name.toUpperCase()),
        backgroundColor: colorPrincipal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: colorPrincipal.withOpacity(0.15),
              padding: const EdgeInsets.all(20),
              child: Image.network(
                pokemon.imageUrl,
                height: 220,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.catching_pokemon, size: 100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: pokemon.types.map((tipo) {
                      return PokemonTypeChip(
                        tipo: tipo,
                        color: ColorHelper.colorPorTipo(tipo),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Estadísticas base',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorPrincipal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _StatBar(label: 'HP', value: pokemon.hp, color: Colors.red),
                  _StatBar(label: 'Ataque', value: pokemon.attack, color: Colors.orange),
                  _StatBar(label: 'Defensa', value: pokemon.defense, color: Colors.blue),
                  const SizedBox(height: 20),
                  Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorPrincipal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder<String>(
                    future: _service.obtenerDescripcion(pokemon.name),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Text(
                        snapshot.data ?? 'Descripción no disponible.',
                        style: const TextStyle(fontSize: 15, height: 1.4),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatBar({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: $value'),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (value / 150).clamp(0, 1),
              backgroundColor: AppConstants.bgGris,
              color: color,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}