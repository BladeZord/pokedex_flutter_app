import 'dart:convert';

import 'package:pokedex_flutter_app/exception/api_exception.dart';
import 'package:pokedex_flutter_app/helpers/http_helper.dart';

import '../models/pokemon_model.dart';

class PokemonService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  /// Obtiene la lista de nombres de Pokémon
  Future<List<String>> obtenerListaNombres({int limit = 30}) async {
    try {
      final response = await HttpHelper.get('$_baseUrl/pokemon?limit=$limit');
      final data = jsonDecode(response.body);
      final List resultados = data['results'];

      return resultados.map<String>((p) => p['name'] as String).toList();
    } on NetworkException {
      rethrow; // Pasa la excepción de red para ser capturada en la UI
    } on ApiException {
      rethrow; // Pasa la excepción de la API para ser capturada en la UI
    }
  }

  /// Obtiene el detalle completo de un Pokémon por nombre
  Future<PokemonModel> obtenerDetallePokemon(String name) async {
    try {
      final response = await HttpHelper.get('$_baseUrl/pokemon/$name');
      final data = jsonDecode(response.body);

      return PokemonModel.fromJson(data);
    } on NetworkException {
      rethrow;
    } on ApiException {
      rethrow;
    }
  }

  /// Descripción tipo Pokédex desde pokemon-species
  Future<String> obtenerDescripcion(String name) async {
    try {
      final response = await HttpHelper.get('$_baseUrl/pokemon-species/$name');
      final data = jsonDecode(response.body);
      final List entries = data['flavor_text_entries'];

      final entryEs = entries.firstWhere(
        (e) => e['language']['name'] == 'es',
        orElse: () => entries.firstWhere(
          (e) => e['language']['name'] == 'en',
          orElse: () => null,
        ),
      );

      if (entryEs == null) return 'Descripción no disponible.';

      return (entryEs['flavor_text'] as String)
          .replaceAll('\n', ' ')
          .replaceAll('\f', ' ');
    } on NetworkException {
      return 'Sin conexión a Internet para cargar la descripción.';
    } on ApiException {
      return 'Descripción no disponible.';
    }
  }

  Future<List<PokemonModel>> obtenerPoolPokemon({int limit = 60}) async {
    final nombres = await obtenerListaNombres(limit: limit);
    final futuros = nombres.map((nombre) => obtenerDetallePokemon(nombre));
    return Future.wait(futuros); // ejecuta todas las peticiones en paralelo
  }

  Future<List<String>> obtenerTiposDisponibles() async {
    final response = await HttpHelper.get('$_baseUrl/type');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List resultados = data['results'];
      return resultados
          .map<String>((t) => t['name'] as String)
          .where((nombre) => nombre != 'unknown' && nombre != 'shadow')
          .toList();
    } else {
      throw Exception('Error al obtener tipos: ${response.statusCode}');
    }
  }

  Future<List<PokemonModel>> obtenerPokemonsPorRegion(int generationId, {int limit = 12}) async {
    final response = await HttpHelper.get('$_baseUrl/generation/$generationId');

    if (response.statusCode != 200) {
      throw Exception('Error al obtener datos de la región');
    }

    final data = jsonDecode(response.body);
    final List species = data['pokemon_species'];

    // Tomamos los primeros elementos según el límite y extraemos los nombres
    final nombres = species
        .take(limit)
        .map<String>((s) => s['name'] as String);

    // Reutilizamos obtenerDetallePokemon en paralelo para evitar peticiones secuenciales lentas
    final futuros = nombres.map((nombre) => obtenerDetallePokemon(nombre));
    return Future.wait(futuros);
  }

  /// Mapa con los nombres de los 3 iniciales por ID de Generación
  static const Map<int, List<String>> _inicialesPorGeneracion = {
    1: ['bulbasaur', 'charmander', 'squirtle'],       // Kanto
    2: ['chikorita', 'cyndaquil', 'totodile'],        // Johto
    3: ['treecko', 'torchic', 'mudkip'],              // Hoenn
    4: ['turtwig', 'chimchar', 'piplup'],             // Sinnoh
    5: ['snivy', 'tepig', 'oshawott'],                // Unova / Teselia
    6: ['chespin', 'fennekin', 'froakie'],            // Kalos
  };

  /// Obtiene únicamente los 3 Pokémon iniciales de una región específica
  Future<List<PokemonModel>> obtenerInicialesPorRegion(int generationId) async {
    final nombres = _inicialesPorGeneracion[generationId] ?? [];
    
    // Reutiliza tu método paralelo
    final futuros = nombres.map((nombre) => obtenerDetallePokemon(nombre));
    return Future.wait(futuros);
  }
}
