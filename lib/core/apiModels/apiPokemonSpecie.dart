
import 'package:myapp/core/generalState.dart';

class ApiPokemonSpecie {
  int id;
  String color;
  String subName;
  String description;
  String growthRate;
  double genderRate;
  int baseHappines;
  int captureRate;
  int stepToHatchEgg;

  String evolutionChainURL;
  int evolutionChainNumber;

  String _getDescription(String language, List<dynamic> jsonList) {
    dynamic valueFound =
        jsonList.firstWhere((value) => value["language"]["name"] == language);

    return valueFound["flavor_text"];
  }

  String _getSubName(String language, List<dynamic> jsonList) {
    dynamic valueFound =
        jsonList.firstWhere((value) => value["language"]["name"] == language);

    return valueFound["genus"];
  }

  ApiPokemonSpecie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    evolutionChainURL = json["evolution_chain"]["url"];

    String auxEvolutionChainUrl = evolutionChainURL.substring(1, evolutionChainURL.length - 1);
    evolutionChainNumber = int.parse(auxEvolutionChainUrl
        .substring(auxEvolutionChainUrl.lastIndexOf("/") + 1));

    color = json["color"]["name"];

    growthRate = json["growth_rate"]["name"];
    baseHappines = json["base_happiness"];
    captureRate = json["capture_rate"];
    stepToHatchEgg = (json["hatch_counter"] + 1) * 255;

    int genderRateAux = json["gender_rate"];
    //Estan en Octavos, entonces si genderRate==1 quiere decir que son 1/8 de chances
    //Pero si es -1 es sin genero
    genderRate = genderRateAux > 0
        ? (genderRateAux).toDouble() / 8
        : genderRateAux.toDouble();

    String lenguage = GeneralData.instance.generalStore.userSettings.language == Languages.English? "en":"es";

    subName = _getSubName(lenguage, json["genera"]);
    description = _getDescription(lenguage, json["flavor_text_entries"]);
  }
}
