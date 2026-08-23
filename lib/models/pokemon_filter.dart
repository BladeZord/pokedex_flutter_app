enum PokemonKeyFilter { nombre, tipoPrimario, tipoSecundario }

extension PokemonFilterKeyLabel on PokemonKeyFilter {
  String get etiqueta {
    switch (this) {
      case PokemonKeyFilter.nombre:
        return 'Nombre';
      case PokemonKeyFilter.tipoPrimario:
        return 'Tipo primario';
      case PokemonKeyFilter.tipoSecundario:
        return 'Tipo secundario';
    }
  }
}


class PokemonFilter {
  final PokemonKeyFilter key;
  final String value;

  const PokemonFilter({required this.key, required this.value});

  @override
  bool operator ==(Object other) => other is PokemonFilter && other.key  == key && other.value == value;

  @override
  int get hashCode => Object.hash(key, value);
}