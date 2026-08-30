import 'dart:convert';

import 'package:pokedex_flutter_app/exception/api_exception.dart';
import 'package:pokedex_flutter_app/helpers/http_helper.dart';

import '../models/pokemon_filter.dart';
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

  List<String>? _nombresCache;

  /// Lista completa de nombres (una sola petición liviana, se guarda en memoria).
  Future<List<String>> obtenerTodosLosNombres() async {
    if (_nombresCache != null) return _nombresCache!;
    _nombresCache = await obtenerListaNombres(limit: 2000);
    return _nombresCache!;
  }

  Future<List<String>> obtenerNombresPorTipo(String tipo) async {
    final response = await HttpHelper.get('$_baseUrl/type/${tipo.toLowerCase()}');
    final data = jsonDecode(response.body);
    final List pokemon = data['pokemon'];
    return pokemon
        .map<String>((entrada) => entrada['pokemon']['name'] as String)
        .toList();
  }

  /// Busca en PokéAPI (no solo en un listado local). Combina nombre y tipos.
  Future<List<PokemonModel>> buscarPokemon({
    required List<PokemonFilter> filtros,
    int maxResultados = 30,
  }) async {
    if (filtros.isEmpty) return [];

    final filtrosNombre = filtros
        .where((filtro) => filtro.key == PokemonKeyFilter.nombre)
        .map((filtro) => filtro.value.trim().toLowerCase())
        .where((valor) => valor.isNotEmpty)
        .toList();
    final tiposPrimarios = filtros
        .where((filtro) => filtro.key == PokemonKeyFilter.tipoPrimario)
        .map((filtro) => filtro.value.toLowerCase())
        .toList();
    final tiposSecundarios = filtros
        .where((filtro) => filtro.key == PokemonKeyFilter.tipoSecundario)
        .map((filtro) => filtro.value.toLowerCase())
        .toList();

    var candidatos = <String>[];

    if (filtrosNombre.isNotEmpty) {
      final todos = await obtenerTodosLosNombres();
      candidatos = todos.where((nombre) {
        return filtrosNombre.every((consulta) => nombre.contains(consulta));
      }).toList();

      if (candidatos.isEmpty && filtrosNombre.length == 1) {
        try {
          final exacto = await obtenerDetallePokemon(filtrosNombre.first);
          return _aplicarFiltrosDeTipo([exacto], tiposPrimarios, tiposSecundarios);
        } on ApiException {
          return [];
        }
      }
    } else {
      final tipoBase = tiposPrimarios.isNotEmpty
          ? tiposPrimarios.first
          : tiposSecundarios.first;
      candidatos = await obtenerNombresPorTipo(tipoBase);
    }

    final limiteCarga = (tiposPrimarios.isNotEmpty || tiposSecundarios.isNotEmpty)
        ? maxResultados * 4
        : maxResultados;

    final nombresACargar = candidatos.take(limiteCarga).toList();
    if (nombresACargar.isEmpty) return [];

    final detalles = await Future.wait(
      nombresACargar.map(obtenerDetallePokemon),
    );

    return _aplicarFiltrosDeTipo(
      detalles,
      tiposPrimarios,
      tiposSecundarios,
    ).take(maxResultados).toList();
  }

  List<PokemonModel> _aplicarFiltrosDeTipo(
    List<PokemonModel> pokemon,
    List<String> tiposPrimarios,
    List<String> tiposSecundarios,
  ) {
    return pokemon.where((item) {
      if (tiposPrimarios.isNotEmpty) {
        if (item.types.isEmpty ||
            !tiposPrimarios.contains(item.types.first.toLowerCase())) {
          return false;
        }
      }
      if (tiposSecundarios.isNotEmpty) {
        if (item.types.length < 2 ||
            !tiposSecundarios.contains(item.types[1].toLowerCase())) {
          return false;
        }
      }
      return true;
    }).toList();
  }
}
