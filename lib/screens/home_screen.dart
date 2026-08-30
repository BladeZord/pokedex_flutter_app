import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/components/card_button.dart';
import 'package:pokedex_flutter_app/screens/choose_pokemon_screen.dart';
import 'package:pokedex_flutter_app/screens/team_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _mostrarProximamente(BuildContext context, String titulo) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(titulo),
          content: Text('La sección de $titulo estará disponible en una próxima actualización.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

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
        child: Column(
          children: [
            Image.asset(
              'assets/images/pokedex_logo.png',
              height: 96,
            ),
            const SizedBox(height: 8),
            const Text(
              'Mi Pokédex Favorita',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Consulta regiones, arma tu equipo y busca Pokémon.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  CardButton(
                    color: Colors.red.shade50,
                    icon: Icon(Icons.public, size: 40, color: Colors.red.shade700),
                    onTap: () {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeamScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Mi Equipo',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CardButton(
                    color: Colors.amber.shade50,
                    icon: Icon(Icons.military_tech, size: 40, color: Colors.amber.shade700),
                    onTap: () => _mostrarProximamente(context, 'Medallas'),
                    child: const Text(
                      'Medallas',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CardButton(
                    color: Colors.blue.shade50,
                    icon: Icon(Icons.flash_on, size: 40, color: Colors.blue.shade700),
                    onTap: () => _mostrarProximamente(context, 'Batallas'),
                    child: const Text(
                      'Batallas',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
