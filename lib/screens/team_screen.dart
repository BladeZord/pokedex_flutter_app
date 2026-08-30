import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/helpers/color_helper.dart';
import 'package:pokedex_flutter_app/models/pokemon_model.dart';
import 'package:pokedex_flutter_app/screens/pokemon_detail_screen.dart';
import 'package:pokedex_flutter_app/states/app_team_scope.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teamScope = AppTeamScope.of(context);
    final equipo = teamScope.equipo;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi equipo (${equipo.length}/${AppTeamScope.capacidadMaxima})'),
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
      ),
      body: equipo.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Todavía no tienes Pokémon en el equipo.\nAgrégalos desde el detalle.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: equipo.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final pokemon = equipo[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: ColorHelper.colorPorTipo(pokemon.types.first)
                        .withValues(alpha: 0.2),
                    backgroundImage: pokemon.imageUrl.isNotEmpty
                        ? NetworkImage(pokemon.imageUrl)
                        : null,
                    child: pokemon.imageUrl.isEmpty
                        ? const Icon(Icons.catching_pokemon)
                        : null,
                  ),
                  title: Text(pokemon.name.toUpperCase()),
                  subtitle: Text(pokemon.types.join(' / ')),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    color: Colors.red.shade700,
                    tooltip: 'Quitar del equipo',
                    onPressed: () => confirmarQuitarDelEquipo(context, pokemon),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailScreen(pokemon: pokemon),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

void confirmarQuitarDelEquipo(BuildContext context, PokemonModel pokemon) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Quitar del equipo'),
        content: Text('¿Quieres retirar a ${pokemon.name} de tu equipo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              AppTeamScope.of(context).quitarDelEquipo(pokemon);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${pokemon.name} fue retirado del equipo.')),
              );
            },
            child: const Text('Quitar'),
          ),
        ],
      );
    },
  );
}
