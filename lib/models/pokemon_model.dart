
class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int hp;
  final int attack;
  final int defense;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.hp,
    required this.attack,
    required this.defense,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final List typesJson = json['types'];
    final List statsJson = json['stats'];

    int _statValue(String statName) {
      final stat = statsJson.firstWhere(
        (s) => s['stat']['name'] == statName,
        orElse: () => null,
      );
      return stat != null ? stat['base_stat'] : 0;
    }

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['other']['official-artwork']['front_default']
          ?? json['sprites']['front_default']
          ?? '',
      types: typesJson.map<String>((t) => t['type']['name'] as String).toList(),
      hp: _statValue('hp'),
      attack: _statValue('attack'),
      defense: _statValue('defense'),
    );
  }
}