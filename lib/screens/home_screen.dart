import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/components/app_search_bar.dart';
import 'package:pokedex_flutter_app/components/pokemon_card.dart';
import 'package:pokedex_flutter_app/models/pokemon_filter.dart';
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
  List<PokemonModel> _pokemonsCargados = [];
  List<PokemonModel> _pokemonsFiltrados = [];
  final List<PokemonFilter> _filtrosActivos = [];

  @override
  void initState() {
    super.initState();

    _pokemonsFuture = _cargarPokemons().then((pokemons) {
      _pokemonsCargados = pokemons;
      _pokemonsFiltrados = pokemons;
      return pokemons;
    });
  }

  List<String> get _tiposDisponibles {
    final tipos = _pokemonsCargados.expand((p) => p.types).toSet().toList();
    tipos.sort();
    return tipos;
  }

  bool _cumpleFiltro(PokemonModel pokemon, PokemonFilter filtro) {
    switch (filtro.key) {
      case PokemonKeyFilter.nombre:
        return pokemon.name.toLowerCase().contains(
              filtro.value.toLowerCase(),
            );
      case PokemonKeyFilter.tipoPrimario:
        return pokemon.types.isNotEmpty &&
            pokemon.types[0].toLowerCase() == filtro.value.toLowerCase();
      case PokemonKeyFilter.tipoSecundario:
        return pokemon.types.length > 1 &&
            pokemon.types[1].toLowerCase() == filtro.value.toLowerCase();
    }
  }

  void _agregarFiltro(PokemonFilter filtro) {
    setState(() {
      _filtrosActivos.removeWhere((f) => f.key == filtro.key);
      _filtrosActivos.add(filtro);
    });
  }

  void _quitarFiltro(PokemonFilter filtro) {
    setState(() {
      _filtrosActivos.remove(filtro);
      _aplicarFiltros();
    });
  }

  void _aplicarFiltros() {
    _pokemonsFiltrados = _pokemonsCargados.where((pokemon) {
      return _filtrosActivos.every((filtro) => _cumpleFiltro(pokemon, filtro));
    }).toList();
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
      _pokemonsFuture = _cargarPokemons().then((pokemons) {
        _pokemonsCargados = pokemons;
        return pokemons;
      });
      _pokemonsFiltrados = [];
      _filtrosActivos.clear();
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
              AppSearchBar(
                tiposDisponibles: _tiposDisponibles,
                filtrosActivos: _filtrosActivos,
                onAgregarFiltro: _agregarFiltro,
                onQuitarFiltro: _quitarFiltro,
                onBuscar: () => setState(_aplicarFiltros),
              ),
              PokemonSearchScreen<PokemonModel>(
                elementos: _filtrosActivos.isEmpty ? pokemons : _pokemonsFiltrados,
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

                    return PokemonCard(
                      pokemon: pokemon,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PokemonDetailScreen(pokemon: pokemon),
                          ),
                        );
                      },
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
