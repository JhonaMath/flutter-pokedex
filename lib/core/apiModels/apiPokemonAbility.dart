


import '../generalState.dart';

class ApiPokemonAbility{
  int id;
  String name;
  String description;

  ApiPokemonAbility();

  ApiPokemonAbility.fromJson(Map<String, dynamic> localJson){

    id = localJson["id"];

    name=_getName("es", localJson['names']);

    String lenguage = GeneralData.instance.generalStore.userSettings.language == Languages.English? "en":"es";

    description = _getDescription(lenguage, localJson["flavor_text_entries"]);


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