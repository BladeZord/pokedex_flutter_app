import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/models/pokemon_model.dart';
import 'package:pokedex_flutter_app/screens/main_navigation_screen.dart';
import 'package:pokedex_flutter_app/states/app_team_scope.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<PokemonModel> _equipo = [];

  void _agregarAlEquipo(PokemonModel pokemon) {
    if (_equipo.any((miembro) => miembro.id == pokemon.id)) {
      return;
    }
    if (_equipo.length >= AppTeamScope.capacidadMaxima) {
      return;
    }
    setState(() {
      _equipo.add(pokemon);
    });
  }

  void _quitarDelEquipo(PokemonModel pokemon) {
    setState(() {
      _equipo.removeWhere((miembro) => miembro.id == pokemon.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTeamScope(
      equipo: List.unmodifiable(_equipo),
      agregarAlEquipo: _agregarAlEquipo,
      quitarDelEquipo: _quitarDelEquipo,
      child: MaterialApp(
        title: 'Mi Pokédex Favorita',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            primary: Colors.red.shade600,
          ),
          useMaterial3: true,
        ),
        home: const MainNavigation(),
      ),
    );
  }
}
