import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/models/pokemon_model.dart';

class AppTeamScope extends InheritedWidget {
  static const int capacidadMaxima = 6;

  final List<PokemonModel> equipo;
  final void Function(PokemonModel pokemon) agregarAlEquipo;
  final void Function(PokemonModel pokemon) quitarDelEquipo;

  const AppTeamScope({
    super.key,
    required this.equipo,
    required this.agregarAlEquipo,
    required this.quitarDelEquipo,
    required super.child,
  });

  static AppTeamScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppTeamScope>();
    assert(scope != null, 'AppTeamScope no encontrado en el árbol de widgets');
    return scope!;
  }

  bool estaEnEquipo(PokemonModel pokemon) {
    return equipo.any((miembro) => miembro.id == pokemon.id);
  }

  @override
  bool updateShouldNotify(AppTeamScope oldWidget) {
    return !listEquals(oldWidget.equipo, equipo);
  }
}
