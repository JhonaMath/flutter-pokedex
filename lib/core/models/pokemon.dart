import 'package:myapp/core/helpers/pokemon_helper.dart';
import 'package:myapp/core/models/character.dart';

class Pokemon extends Character {
  int generation;
  List<PokemonTypes> types = [];
  PokemonTypes type1;
  PokemonTypes type2;
  PokemonTypes type3;

  Pokemon.Empty() : super.Empty();

  Pokemon(
      id, name, imageURL, this.generation, this.type1, this.type2, this.type3)
      : super(id, name, imageURL);

  Pokemon.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    generation = json['name'];
    type1 = json['email'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': type1,
      };
}
