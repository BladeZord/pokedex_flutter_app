import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/components/app_loading.dart';
import 'package:pokedex_flutter_app/components/app_search_bar.dart';
import 'package:pokedex_flutter_app/components/pokemon_card.dart';
import 'package:pokedex_flutter_app/models/pokemon_filter.dart';
import 'package:pokedex_flutter_app/models/pokemon_model.dart';
import 'package:pokedex_flutter_app/screens/pokemon_detail_screen.dart';
import 'package:pokedex_flutter_app/services/pokemon_service.dart';

class PokemonCatalogScreen extends StatefulWidget {
  const PokemonCatalogScreen({super.key});

  @override
  State<PokemonCatalogScreen> createState() => _PokemonCatalogScreenState();
}

class _PokemonCatalogScreenState extends State<PokemonCatalogScreen> {
  final PokemonService _service = PokemonService();

  late Future<void> _cargaInicial;
  List<PokemonModel> _todos = [];
  List<PokemonModel> _filtrados = [];
  List<PokemonFilter> _filtros = [];
  List<String> _tipos = [];

  @override
  void initState() {
    super.initState();
    _cargaInicial = _cargar();
  }

  Future<void> _cargar() async {
    final resultados = await Future.wait([
      _service.obtenerPoolPokemon(limit: 30),
      _service.obtenerTiposDisponibles(),
    ]);

    if (!mounted) return;

    setState(() {
      _todos = resultados[0] as List<PokemonModel>;
      _tipos = resultados[1] as List<String>;
      _filtrados = List.of(_todos);
    });
  }

  void _aplicarFiltros() {
    setState(() {
      _filtrados = _todos.where(_coincideConFiltros).toList();
    });
  }

  bool _coincideConFiltros(PokemonModel pokemon) {
    for (final filtro in _filtros) {
      switch (filtro.key) {
        case PokemonKeyFilter.nombre:
          if (!pokemon.name.toLowerCase().contains(filtro.value.toLowerCase())) {
            return false;
          }
        case PokemonKeyFilter.tipoPrimario:
          if (pokemon.types.isEmpty ||
              pokemon.types.first.toLowerCase() != filtro.value.toLowerCase()) {
            return false;
          }
        case PokemonKeyFilter.tipoSecundario:
          if (pokemon.types.length < 2 ||
              pokemon.types[1].toLowerCase() != filtro.value.toLowerCase()) {
            return false;
          }
      }
    }
    return true;
  }

  void _abrirDetalle(PokemonModel pokemon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailScreen(pokemon: pokemon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Pokémon'),
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
        tooltip: 'Recargar listado',
        onPressed: () {
          setState(() {
            _cargaInicial = _cargar();
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: FutureBuilder<void>(
        future: _cargaInicial,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              _todos.isEmpty) {
            return const AppLoading(mensaje: 'Cargando Pokédex...');
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudo cargar el catálogo.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return Column(
            children: [
              AppSearchBar(
                tiposDisponibles: _tipos,
                filtrosActivos: _filtros,
                onAgregarFiltro: (filtro) {
                  setState(() {
                    if (!_filtros.contains(filtro)) {
                      _filtros = [..._filtros, filtro];
                    }
                  });
                },
                onQuitarFiltro: (filtro) {
                  setState(() {
                    _filtros = _filtros.where((item) => item != filtro).toList();
                  });
                  _aplicarFiltros();
                },
                onBuscar: _aplicarFiltros,
              ),
              Expanded(
                child: _filtrados.isEmpty
                    ? const Center(child: Text('No hay resultados para esos filtros.'))
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 88),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: _filtrados.length,
                        itemBuilder: (context, index) {
                          final pokemon = _filtrados[index];
                          return PokemonCard(
                            pokemon: pokemon,
                            onTap: () => _abrirDetalle(pokemon),
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
