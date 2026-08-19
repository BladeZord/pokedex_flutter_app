
import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/screens/home_screen.dart';
import 'package:pokedex_flutter_app/screens/pokemon_search_screen.dart';

class MainNavigation extends  StatefulWidget 
{
  const MainNavigation({super.key});

  @override
  State<StatefulWidget> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
{
  int _indiceSeleccionado = 0;
  final List<Widget> _pantallas = const [
    // PokemonSearchScreen(pokemon: new PokemonModel());
    HomeScreen()
  ];

  void _cambiarPantalla(int indice){
    setState(() {
      _indiceSeleccionado = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pantallas[_indiceSeleccionado],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceSeleccionado,
        onTap: _cambiarPantalla,
        selectedItemColor: Colors.red.shade100,
        unselectedItemColor: Colors.grey,
        type:BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Buscar',
          ),
        ],
        ),
    );
  }
}