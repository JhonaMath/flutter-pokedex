
class ApiPokemonStats {
  int speed;
  int attack;
  int defense;
  int specialAttack;
  int specialDefense;
  int hp;

  ApiPokemonStats.fromJson(List<dynamic> json) {
    for (int i = 0; i < json.length; i++) {
      String statType = json[i]["stat"]["name"];
      int value = json[i]["base_stat"];
      switch (statType) {
        case "speed":
          {
            speed = value;
          }
          break;
        case "attack":
          {
            attack = value;
          }
          break;
        case "defense":
          {
            defense = value;
          }
          break;
        case "special-defense":
          {
            specialDefense = value;
          }
          break;
        case "special-attack":
          {
            specialAttack = value;
          }
          break;
        case "hp":
          {
            hp = value;
          }
          break;
      }
    }
  }

  String toString() {
    return "(speed=$speed, attack=$attack, defense=$defense, specialAttack=$specialAttack, specialDefense=$specialDefense, hp=$hp)";
  }
}

class ApiPokemonAbility_FromApiPokemon{
  int id;
  String name;
  bool isHidden;
  ApiPokemonAbility_FromApiPokemon();

  ApiPokemonAbility_FromApiPokemon.fromJson(Map<String, dynamic> localJson){

    name=localJson['ability']['name'];
    isHidden = localJson['is_hidden'];

    String url = localJson['ability']['url'];
    url=url.substring(1,url.length-1);
    id = int.parse(url.substring(url.lastIndexOf("/") + 1));

  }
}

class ApiPokemon {
  int id;
  String name;
  String imageUrl;
  String type;
  ApiPokemonStats stats;
  int height;
  int weight;
  List<String> sprites = [];
  List<String> types =[];
  List<ApiPokemonAbility_FromApiPokemon> abilities = [];

  String specieUrl;

  ApiPokemon();

  ApiPokemon.fromJson(Map<String, dynamic> localJson) {
    id = localJson['id'];

    name = localJson['name'];
    weight = localJson["weight"];
    height = localJson["height"];

    dynamic types = localJson['types'];
    dynamic sprites = localJson['sprites'];
    dynamic abilities = localJson['abilities'];

    //SPRITES
    imageUrl = sprites['front_default'];
    this.sprites.add(imageUrl);
    this.sprites.add(sprites['front_shiny']);

    //TYPES
    for (int i = 0; types.length > i; i++) {

      dynamic type = types[i]['type'];
      this.type = type['name'];
      if (i == 0)
        this.types.add(type['name']);
      else
        this.types.insert(types[i]['slot'] - 1, type['name']);
    }

    //ABILITIES
    for (int i = 0; abilities.length > i; i++) {

      ApiPokemonAbility_FromApiPokemon ability = ApiPokemonAbility_FromApiPokemon.fromJson(abilities[i]);

      this.abilities.add(ability);

    }

    specieUrl = localJson["species"]["url"];

    stats = ApiPokemonStats.fromJson(localJson["stats"]);

  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
