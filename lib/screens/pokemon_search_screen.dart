import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/states/Pokemon_search_state.dart';

class PokemonSearchScreen<T> extends StatefulWidget {
  final List<T> elementos;
  final String Function(T item) valorABuscar;
  final ValueChanged<List<T>> listadoCambiado;
  final String textoSugerido;

  const PokemonSearchScreen({
    super.key,
    required this.elementos,
    required this.valorABuscar,
    required this.listadoCambiado,
    this.textoSugerido = 'Buscar...',
  });

  @override
  State<PokemonSearchScreen<T>> createState() =>
      PokemonSearchState<T>();
}