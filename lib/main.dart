import 'package:flutter/material.dart';
// import 'package:pokedex_flutter_app/models/pokemon_model.dart';
import 'package:pokedex_flutter_app/providers/team_provider.dart';
import 'package:pokedex_flutter_app/screens/main_navigation_screen.dart';
// import 'package:pokedex_flutter_app/states/app_team_scope.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => TeamProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

// class _MyAppState extends State<MyApp> {
//   final List<PokemonModel> _equipo = [];

//   void _agregarAlEquipo(PokemonModel pokemon) {
//     if (_equipo.any((miembro) => miembro.id == pokemon.id)) {
//       return;
//     }
//     if (_equipo.length >= AppTeamScope.capacidadMaxima) {
//       return;
//     }
//     setState(() {
//       _equipo.add(pokemon);
//     });
//   }

//   void _quitarDelEquipo(PokemonModel pokemon) {
//     setState(() {
//       _equipo.removeWhere((miembro) => miembro.id == pokemon.id);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppTeamScope(
//       equipo: List.unmodifiable(_equipo),
//       agregarAlEquipo: _agregarAlEquipo,
//       quitarDelEquipo: _quitarDelEquipo,
//       child: MaterialApp(
//         title: 'Mi Pokédex Favorita',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: Colors.red,
//             primary: Colors.red.shade600,
//           ),
//           useMaterial3: true,
//         ),
//         home: const MainNavigation(),
//       ),
//     );
//   }
// }
