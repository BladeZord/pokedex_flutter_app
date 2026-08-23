import 'package:flutter/material.dart';
import '../screens/pokemon_search_screen.dart';

class PokemonSearchState<T> extends State<PokemonSearchScreen<T>> {
  final TextEditingController _controller = TextEditingController();

  void _buscar(String texto) {
    final consulta = texto.trim().toLowerCase();

    if (consulta.isEmpty) {
      widget.listadoCambiado(widget.elementos);
      setState(() {});
      return;
    }

    final resultados = widget.elementos.where((item) {
      final valor = widget.valorABuscar(item).toLowerCase();

      return valor.contains(consulta);
    }).toList();

    widget.listadoCambiado(resultados);

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: TextField(
        controller: _controller,
        onChanged: _buscar,
        decoration: InputDecoration(
          hintText: widget.textoSugerido,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    _buscar('');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}