import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/models/pokemon_model.dart';
import 'package:pokedex_flutter_app/screens/pokemon_search_screen.dart';

import '../services/pokemon_service.dart';
import 'pokemon_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PokemonService _service = PokemonService();
  late Future<List<PokemonModel>> _pokemonsFuture;
  List<PokemonModel> _pokemonsFiltrados = [];

  @override
  void initState() {
    super.initState();

    _pokemonsFuture = _cargarPokemons().then((pokemons) {
      _pokemonsFiltrados = pokemons;
      return pokemons;
    });
  }

  Future<List<PokemonModel>> _cargarPokemons() async {
    final nombres = await _service.obtenerListaNombres(limit: 20);
    final List<PokemonModel> pokemons = [];
    for (final nombre in nombres) {
      final detalle = await _service.obtenerDetallePokemon(nombre);
      pokemons.add(detalle);
    }
    return pokemons;
  }

  void _recargar() {
    setState(() {
      _pokemonsFuture = _cargarPokemons();
      _pokemonsFiltrados = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
        title: const Text(
          'Mi Pokédex Favorita',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _recargar,
          ),
        ],
      ),
      body: FutureBuilder<List<PokemonModel>>(
        future: _pokemonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar Pokémon:\n${snapshot.error}'),
            );
          }

          final pokemons = snapshot.data ?? [];


          return Column(
            children: [
              PokemonSearchScreen<PokemonModel>(
                elementos: pokemons,
                valorABuscar: (pokemon) => pokemon.name,
                listadoCambiado: (resultados) {
                  setState(() {
                    _pokemonsFiltrados = resultados;
                  });
                },
                textoSugerido: 'Buscar Pokémon',
              ),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _pokemonsFiltrados.length,
                  itemBuilder: (context, index) {
                    final pokemon = _pokemonsFiltrados[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PokemonDetailScreen(pokemon: pokemon),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                pokemon.imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.catching_pokemon,
                                    size: 50,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                pokemon.name.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
