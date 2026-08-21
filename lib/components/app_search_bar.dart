import 'package:flutter/material.dart';
import 'package:pokedex_flutter_app/constants/app_constants.dart';
import 'package:pokedex_flutter_app/models/pokemon_filter.dart';

class AppSearchBar extends StatefulWidget {
  final List<String> tiposDisponibles;
  final List<PokemonFilter> filtrosActivos;
  final ValueChanged<PokemonFilter> onAgregarFiltro;
  final ValueChanged<PokemonFilter> onQuitarFiltro;
  final VoidCallback onBuscar;

  const AppSearchBar({
    super.key,
    required this.tiposDisponibles,
    required this.filtrosActivos,
    required this.onAgregarFiltro,
    required this.onQuitarFiltro,
    required this.onBuscar,
  });

  @override
  State<AppSearchBar> createState() => AppSearchBarState();
}

class AppSearchBarState extends State<AppSearchBar> {
  PokemonKeyFilter _claveSeleccionada = PokemonKeyFilter.nombre;
  final TextEditingController _valorController = TextEditingController();
  String? _tipoSeleccionado;

  bool get _esFiltroDeTipo =>
      _claveSeleccionada == PokemonKeyFilter.tipoPrimario ||
      _claveSeleccionada == PokemonKeyFilter.tipoSecundario;

  void _agregarFiltro() {
    final valor = _esFiltroDeTipo
        ? _tipoSeleccionado
        : _valorController.text.trim();

    if (valor == null || valor.isEmpty) {
      return; // Se detiene el flujo si es nulo o vacio
    }

    widget.onAgregarFiltro(
      PokemonFilter(key: _claveSeleccionada, value: valor),
    );

    setState(() {
      _valorController.clear();
      _tipoSeleccionado = null;
    });
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filtros de búsqueda',
            style: AppConstants.estiloFuenteGris,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<PokemonKeyFilter>(
                  value: _claveSeleccionada,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  items: PokemonKeyFilter.values
                      .map(
                        (clave) => DropdownMenuItem(
                          value: clave,
                          child: Text(clave.etiqueta),
                        ),
                      )
                      .toList(),
                  onChanged: (clave) {
                    if (clave == null) return;
                    setState(() {
                      _claveSeleccionada = clave;
                      _valorController.clear();
                      _tipoSeleccionado = null;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: _esFiltroDeTipo
                    ? DropdownButtonFormField<String>(
                        value: _tipoSeleccionado,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Selecciona un tipo',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.tiposDisponibles
                            .map(
                              (tipo) => DropdownMenuItem(
                                value: tipo,
                                child: Text(tipo),
                              ),
                            )
                            .toList(),
                        onChanged: (tipo) {
                          setState(() => _tipoSeleccionado = tipo);
                        },
                      )
                    : TextField(
                        controller: _valorController,
                        decoration: const InputDecoration(
                          isDense: true,
                          hintText: 'Valor a buscar',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: (_) => _agregarFiltro(),
                      ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _agregarFiltro,
                icon: const Icon(Icons.add_circle),
                color: Colors.red.shade600,
                tooltip: 'Agregar filtro',
              ),
            ],
          ),
          if (widget.filtrosActivos.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.filtrosActivos
                  .map(
                    (filtro) => InputChip(
                      label: Text('${filtro.key.etiqueta}: ${filtro.value}'),
                      onDeleted: () => widget.onQuitarFiltro(filtro),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: widget.onBuscar,
              icon: const Icon(Icons.search),
              label: const Text('Buscar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
