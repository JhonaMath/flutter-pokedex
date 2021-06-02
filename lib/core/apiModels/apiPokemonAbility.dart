


class ApiPokemonAbility{
  int id;
  String name;
  String description;

  ApiPokemonAbility();

  ApiPokemonAbility.fromJson(Map<String, dynamic> localJson){

    id = localJson["id"];

    name=_getName("en", localJson['names']);

    description = _getDescription("en", localJson["flavor_text_entries"]);


  }

  String _getName(String language, List<dynamic> jsonList) {
    dynamic valueFound =
    jsonList.firstWhere((value) => value["language"]["name"] == language);

    return valueFound["name"];
  }

  String _getDescription(String language, List<dynamic> jsonList) {
    dynamic valueFound =
    jsonList.firstWhere((value) => value["language"]["name"] == language);

    return valueFound["flavor_text"];
  }

}