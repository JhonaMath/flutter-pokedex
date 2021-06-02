import 'package:myapp/core/apiModels/apiPokemonEvolutionChain.dart';
import 'package:myapp/core/models/pokemon.dart';

class PokemonStats {
  int speed;
  int attack;
  int defense;
  int specialAttack;
  int specialDefense;
  int hp;
}

class PokemonAbility{
  int id;
  String name;
  bool isHidden;
  String description;
}

class PokemonPokedex extends Pokemon {
  PokemonStats stats;
  int height;
  int weight;
  List<String> sprites = [];
  List<PokemonAbility> abilities = [];

  String color;
  String subName;
  String description;
  String growthRate;
  double genderRate;
  int baseHappines;
  int captureRate;
  int stepToHatchEgg;

  EvolutionNode pokemonEvolution;

  PokemonPokedex.Empty() : super.Empty();

  PokemonPokedex(id, name, imageURL, generation, type1, type2, type3)
      : super(id, name, imageURL, generation, type1, type2, type3);

  getMaleRate() {
    return genderRate == -1 ? 0 : 100 - genderRate * 100;
  }

  getFemaleRate() {
    return genderRate == -1 ? 0 : genderRate * 100;
  }
}
