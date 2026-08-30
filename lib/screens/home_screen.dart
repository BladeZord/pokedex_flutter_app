import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/components/card_button.dart';
import 'package:pokedex_flutter_app/screens/choose_pokemon_screen.dart'; // Importa la pantalla de regiones

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade600,
        title: const Text(
          'Pokédex Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            CardButton(
              color: Colors.red.shade50,
              icon: Icon(Icons.public, size: 40, color: Colors.red.shade700),
              onTap: () {
                // Navegación hacia la pantalla de Regiones
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChoosePokemonScreen(),
                  ),
                );
              },
              child: const Text(
                'Regiones',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardButton(
              color: Colors.orange.shade50,
              icon: Icon(Icons.shield, size: 40, color: Colors.orange.shade700),
              onTap: () {
                // Acción para Mi Equipo
              },
              child: const Text(
                'Mi Equipo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardButton(
              color: Colors.amber.shade50,
              icon: Icon(Icons.military_tech, size: 40, color: Colors.amber.shade700),
              onTap: () {
                // Acción para Medallas
              },
              child: const Text(
                'Medallas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardButton(
              color: Colors.blue.shade50,
              icon: Icon(Icons.flash_on, size: 40, color: Colors.blue.shade700),
              onTap: () {
                // Acción para Batallas
              },
              child: const Text(
                'Batallas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}