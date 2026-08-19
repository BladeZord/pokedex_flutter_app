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
}