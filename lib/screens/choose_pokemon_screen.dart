
import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/models/pokemon_model.dart';
import 'package:pokedex_flutter_app/services/pokemon_service.dart';
import 'package:pokedex_flutter_app/components/card_button.dart';

class ChoosePokemonScreen extends StatefulWidget{
 const ChoosePokemonScreen({super.key});

  @override
  State<ChoosePokemonScreen> createState() => _ChoosePokemonScreenState();
}

class _ChoosePokemonScreenState extends State<ChoosePokemonScreen> {
   final PokemonService _service = PokemonService();
  // Mapa básico de Región -> ID de Generación en PokéAPI
  final Map<String, int> _regiones = {
    'Kanto': 1,
    'Johto': 2,
    'Hoenn': 3,
    'Sinnoh': 4,
    'Unova': 5,
    'Kalos': 6,
  };

  String? _regionSeleccionada;
  late Future<List<PokemonModel>> _pokemonsFuture;

  // Obtiene los Pokémon pertenecientes a una generación/región específica


  void _seleccionarRegion(String region, int generationId) {
    setState(() {
      _regionSeleccionada = region;
      _pokemonsFuture = _service.obtenerInicialesPorRegion(generationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_regionSeleccionada == null 
            ? 'Selecciona una Región' 
            : 'Pokémon de $_regionSeleccionada'),
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _regionSeleccionada == null
            ? _buildListaRegiones()
            : _buildListaPokemons(),
      ),
    );
  }

  // Vista 1: Cuadrícula de botones con las Regiones
  Widget _buildListaRegiones() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _regiones.length,
      itemBuilder: (context, index) {
        final regionName = _regiones.keys.elementAt(index);
        final genId = _regiones.values.elementAt(index);

        return CardButton(
          icon: Icon(Icons.map, size: 36, color: Colors.red.shade700),
          color: Colors.red.shade50,
          onTap: () => _seleccionarRegion(regionName, genId),
          child: Text(
            regionName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  // Vista 2: Carga y muestra los Pokémon de la región elegida
  Widget _buildListaPokemons() {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => setState(() => _regionSeleccionada = null),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Cambiar de Región'),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: FutureBuilder<List<PokemonModel>>(
            future: _pokemonsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final pokemons = snapshot.data ?? [];

              return ListView.builder(
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = pokemons[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        pokemon.imageUrl ?? '',
                        errorBuilder: (_, __, ___) => const Icon(Icons.catching_pokemon),
                      ),
                      title: Text(pokemon.name.toUpperCase()),
                      subtitle: Text('Tipos: ${pokemon.types.join(", ")}'),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}