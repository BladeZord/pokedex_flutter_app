import 'package:flutter/foundation.dart';
import 'package:pokedex_flutter_app/models/pokemon_model.dart';

class TeamProvider extends ChangeNotifier {
  static const int capacidadMaxima = 6;
  final List<PokemonModel> _equipo = [];

  List<PokemonModel> get equipo => List.unmodifiable(_equipo);

  bool estaEnEquipo(PokemonModel pokemon) =>
      _equipo.any((miembro) => miembro.id == pokemon.id);

  bool agregarAlEquipo(PokemonModel pokemon) {
    if (estaEnEquipo(pokemon) || _equipo.length >= capacidadMaxima) return false;

    _equipo.add(pokemon);

    notifyListeners();

    return true;
  }

  void quitarDelEquipo(PokemonModel pokemon) {
    _equipo.removeWhere((miembro) => miembro.id == pokemon.id);

    notifyListeners();
  }
}
