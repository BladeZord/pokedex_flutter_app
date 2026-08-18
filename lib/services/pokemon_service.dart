import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokemonService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  /// Obtiene la lista de nombres de Pokémon (primera generación / cantidad limitada)
  Future<List<String>> obtenerListaNombres({int limit = 30}) async {
    final url = Uri.parse('$_baseUrl/pokemon?limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List resultados = data['results'];
      return resultados.map<String>((p) => p['name'] as String).toList();
    } else {
      throw Exception('Error al obtener la lista: ${response.statusCode}');
    }
  }

  /// Obtiene el detalle completo de un Pokémon por nombre
  Future<PokemonModel> obtenerDetallePokemon(String name) async {
    final url = Uri.parse('$_baseUrl/pokemon/$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PokemonModel.fromJson(data);
    } else {
      throw Exception('Error al obtener el Pokémon: ${response.statusCode}');
    }
  }

  /// Opcional: descripción tipo Pokédex desde pokemon-species
  Future<String> obtenerDescripcion(String name) async {
    final url = Uri.parse('$_baseUrl/pokemon-species/$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
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
    } else {
      return 'Descripción no disponible.';
    }
  }
}