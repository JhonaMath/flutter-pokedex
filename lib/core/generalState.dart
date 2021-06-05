import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:myapp/core/helpers/CoreHelper.dart';
import 'package:myapp/core/models/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/helpers/pokemon_helper.dart';
import 'package:myapp/core/models/pokemon_pokedex.dart';
import 'package:tinycolor/tinycolor.dart';

import 'apiClient.dart';
import 'models/hints.dart';

part 'generalState.g.dart';

class _GeneralStore = GeneralStoreBase with _$_GeneralStore;


enum ImagesTypes{
  Static,
  EightBits,
  HDImages,
  Gif
}

enum Languages{
  English,
  Spanish,
}

class Settings{
  ImagesTypes imagestype;
  Theme theme;
  Languages language;

  Settings clone(){
    Settings newSettings=new Settings();
    newSettings.imagestype=this.imagestype;
    newSettings.theme=this.theme;
    newSettings.language=this.language;
    return newSettings;
  }

}

abstract class GeneralStoreBase with Store {

  // region Observables
  @observable
  bool initializing = true;

  @observable
  int value = 0;

  @observable
  bool showPokemon = false;

  @observable
  bool winGame = false;

  @observable
  bool lossGame = false;

  @observable
  String selectedLetters = "";

  @observable
  Pokemon currentPokemon;

  @observable
  int countLifes=5;

  @observable
  Hints hints= new Hints();

  @observable
  bool hideImage = true;

  @observable
  int currentPoints=300;

  @observable
  MaterialColor colorCustom = MaterialColor(GeneralData.appStaticMainColor.value, GeneralData.color);

  @observable
  int totalPoints=0;

  @observable
  bool isLoadingImagePokemon=false;

  @observable
  int timeElapsed=0;

  @observable
  Settings userSettings;
  //endregion

  double bonusTime=0;

  @observable
  ImagesTypes currentImageType=ImagesTypes.EightBits;

  @action
  void setCurrentImageType(ImagesTypes imageType){
    this.currentImageType=imageType;
  }


  @action
  void setUserSettings(Settings newSetting){
    this.userSettings=newSetting;
  }

  @action
  void setTimeElapsed(int value){
    this.timeElapsed=value;
  }

  @action
  void setIsLoadingImagePokemon(bool value){
    this.isLoadingImagePokemon=value;
  }

  @action
  void setThemeColorCustom(MaterialColor materialColor){
    this.colorCustom=materialColor;
  }

  @action
  void setHintType(bool value, int position){
    this.hints.typesShadowed[position]=value;
  }

  @action
  void setHints(Hints newHint){
    this.hints=Hints.from(newHint);
    recalcularCurrentPoints();
  }

  @action
  void recalcularCurrentPoints(){

    int maxPoints=300;

    if (!this.hints.shadowedPokemon){
      maxPoints= (maxPoints/2).floor();

      if (!this.hints.typesShadowed[0]){
        maxPoints= (maxPoints-15/2).floor();
      }
      if (!this.hints.typesShadowed[1]){
        maxPoints= (maxPoints-15/2).floor();
      }
      if (!this.hints.shadowedGen){
        maxPoints= (maxPoints-15/2).floor();
      }
    }else{
      if (!this.hints.typesShadowed[0]){
        maxPoints= (maxPoints-15).floor();
      }
      if (!this.hints.typesShadowed[1]){
        maxPoints= (maxPoints-15).floor();
      }
      if (!this.hints.shadowedGen){
        maxPoints= (maxPoints-15).floor();
      }
    }

    this.currentPoints=maxPoints;
  }


  @action
  void addSelectedLetter(String letter) {
    selectedLetters = selectedLetters + letter;
    if (!currentPokemon.name.contains(letter)){
      countLifes--;
      if (countLifes==0){
        lossGame=true;
        if (totalPoints>GeneralData.instance.currentHighScore){
          GeneralData.instance.isCurrentRecordBeated=true;
          GeneralData.instance.currentHighScore=totalPoints;
        }else{
          GeneralData.instance.isCurrentRecordBeated=false;
        }
      }
    }

    if (verifyWin(currentPokemon.name, selectedLetters)) {
      showPokemon = true;
      winGame = true;

      bonusTime=(2-(timeElapsed<=5?0:(timeElapsed-5)*0.2)).toDouble();

      totalPoints=(this.currentPoints*bonusTime).ceil()+totalPoints;
      if (!GeneralData.instance.catchedPokemons.contains(currentPokemon.id)){
        GeneralData.instance.catchedPokemons.add(currentPokemon.id);
        GeneralData.instance.encounteredPokemons.remove(currentPokemon.id);
      }
    }
  }

  bool verifyWin(String textVerified, String text) {
    String auxStr = textVerified;
    for (int i = 0; i < text.length; i++) {
      auxStr = auxStr.replaceAll(text[i], "");
    }

    return auxStr.length == 0;
  }

  @action
  void setCurrentPokemon(Pokemon newPokemon) {
    currentPokemon = newPokemon;
  }

  @action
  void setShowPokemon(bool value) {
    showPokemon = value;
  }

  @action
  void setInitializingState(bool value) {
    initializing = value;
  }

  @action
  Future<dynamic> fetchPokemon(int id) async {
    final pokeApi = await ApiClient.fetchPokemon(id);

    Pokemon poke = new Pokemon.Empty();

    poke.id=pokeApi.id;
    poke.name=pokeApi.name;
    poke.imageURL=pokeApi.imageUrl;

    poke.imageURL= getImageUrlById(id, currentImageType);

    poke.generation=generationForPokemon(pokeApi.id);
    for (int i=0; i<pokeApi.types.length; i++){
      poke.types.add(stringToPokemonType[pokeApi.types[i]]);
    }

    currentPokemon = poke;
    return poke;
  }

  String getImageUrlById(int id, [ImagesTypes type = ImagesTypes.Static]){

    if (type==ImagesTypes.Static){
      return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + (id).toString() + ".png";
    }else if(type==ImagesTypes.Gif){
      return "https://randompokemon.com/sprites/normal/"+ id.toString() + ".gif";
    }else if(type==ImagesTypes.HDImages){
      if (id<810){
        return "https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/"+ id.toString().padLeft(3,"0") + ".png";
      }else{
        return "https://randompokemon.com/sprites/png/normal/"+ id.toString().padLeft(3,"0") +".png";
      }
    }else{
      return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/"+ id.toString() +".png";
    }

  }

  Future<dynamic> fetchPokemonPokedex(int id) async {

    PokemonPokedex poke = new PokemonPokedex.Empty();

    final pokeApiResponse = ApiClient.fetchPokemon(id).then((pokeApi) async{
      //Pokemon
      poke.id = pokeApi.id;
      poke.name = pokeApi.name;
      poke.imageURL = pokeApi.imageUrl;

      poke.imageURL=getImageUrlById(id, currentImageType);

      poke.generation = generationForPokemon(poke.id);
      poke.height = pokeApi.height;
      poke.weight = pokeApi.weight;
      poke.sprites = [];

      poke.sprites.add(this.getImageUrlById(id, ImagesTypes.HDImages));
      poke.sprites.add(this.getImageUrlById(id, ImagesTypes.EightBits));

      poke.sprites.addAll(pokeApi.sprites);
      // poke.sprites.add(this.getImageUrlById(id, ImagesTypes.Gif));

      PokemonStats stats = new PokemonStats();
      stats.defense = pokeApi.stats.defense;
      stats.attack = pokeApi.stats.attack;
      stats.speed = pokeApi.stats.speed;
      stats.specialAttack = pokeApi.stats.specialAttack;
      stats.specialDefense = pokeApi.stats.specialDefense;
      stats.hp = pokeApi.stats.hp;

      poke.stats = stats;

      for (int i = 0; i < pokeApi.types.length; i++) {
        poke.types.add(stringToPokemonType[pokeApi.types[i]]);
      }

      List<Future> abilitiesResponses = [];

      for (int i = 0; i < pokeApi.abilities.length; i++) {

        final abilityApiResponse = ApiClient.fetchPokemonAbility(pokeApi.abilities[i].id).then((abilityApi){
          PokemonAbility ability = new PokemonAbility();
          ability.id=abilityApi.id;
          ability.name=abilityApi.name;
          ability.isHidden=pokeApi.abilities[i].isHidden;
          ability.description = abilityApi.description;

          poke.abilities.add(ability);
        });

        abilitiesResponses.add(abilityApiResponse);


      }

      await Future.wait(abilitiesResponses);

    });
    final pokemonApiSpecieResponse = ApiClient.fetchPokemonSpecie(id).then((pokemonApiSpecie) async {
      final pokemonApiEvolutionChain = await ApiClient.fetchPokemonEvolution(
          pokemonApiSpecie.evolutionChainNumber);

      //PokeSpecies
      poke.color = pokemonApiSpecie.color;
      poke.subName = pokemonApiSpecie.subName;
      poke.description = pokemonApiSpecie.description;
      poke.growthRate = pokemonApiSpecie.growthRate;
      poke.genderRate = pokemonApiSpecie.genderRate;
      poke.baseHappines = pokemonApiSpecie.baseHappines;
      poke.captureRate = pokemonApiSpecie.captureRate;
      poke.stepToHatchEgg = pokemonApiSpecie.stepToHatchEgg;

      //Pokemon Evolution Chain
      poke.pokemonEvolution = pokemonApiEvolutionChain.pokemonRoot;
    });

    await Future.wait([pokeApiResponse, pokemonApiSpecieResponse]);

    return poke;
  }

  @action
  void reset() {
    selectedLetters = "";
    showPokemon = false;
    winGame=false;
    lossGame=false;
    hints=new Hints();
    recalcularCurrentPoints();
  }

  @action
  void resetAll() {
    selectedLetters = "";
    showPokemon = false;
    winGame=false;
    lossGame=false;
    hints=new Hints();

    countLifes=5;

    totalPoints=0;

    recalcularCurrentPoints();

  }

  @action
  void increment() {
    value++;
    Pokemon poke = GeneralData.instance.generalStore.currentPokemon;
    Random rnd = new Random();

    poke.imageURL =
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" +
            (rnd.nextInt(800) + 1).toString() +
            ".png";

    GeneralData.instance.generalStore.setCurrentPokemon(poke);
  }

  @action
  void shouldShowImage(bool visiblility) {
    hideImage = visiblility;
  }

  @action
  void changeLenguage(Languages language) {
    userSettings.language = language;
  }
}

//region Themes
class Theme {
  Color appMainColor;
  Color appMainColorLight;
  Color appMainColorDark;
  Color appSecondaryColor;
  Color appSecondaryColorLight;

  Theme({this.appMainColor=Colors.blue,this.appMainColorLight=Colors.lightBlueAccent,this.appMainColorDark=Colors.deepOrange,this.appSecondaryColor=Colors.orange,this.appSecondaryColorLight=Colors.deepOrangeAccent});
}

final tema1 = new Theme(
    appMainColor: Colors.red,
    appMainColorLight: Colors.redAccent,
    appMainColorDark:new Color(0xFF4118E2),
    appSecondaryColor:new Color(0xFFFB5012),
    appSecondaryColorLight:new Color(0xFFFF7C11),
);

final tema2 = new Theme(
  appMainColor: new Color(0xFFF52F57),
  appMainColorLight: new Color(0xFFFF5678),
  appMainColorDark:new Color(0xFF3F000C),
  appSecondaryColor:new Color(0xFFF3752B),
  appSecondaryColorLight:new Color(0xFFF79D5C),
);

final tema3 = new Theme(
  appMainColor: new Color(0xFF4F0147),//0xFF35012C
  appMainColorLight: new Color(0xFF8E0180),
  appMainColorDark:new Color(0xFF290025),
  appSecondaryColor:new Color(0xFF7101B2),
  appSecondaryColorLight:new Color(0xFF3A015C),
);

final temaNaranja = new Theme(
  appMainColor: new Color(0xFFF25C05),//0xFF35012C
  appMainColorLight: new Color(0xFFF28705),
  appMainColorDark:new Color(0xFFBF573F),
  appSecondaryColor:new Color(0xFFF20530),
  appSecondaryColorLight:new Color(0xFFF2CB05),
);

final temaRojo = new Theme(
  appMainColor: new Color(0xFFF22727),//0xFF35012C
  appMainColorLight: new Color(0xFFF26B6B),
  appMainColorDark:new Color(0xFFF20505),
  appSecondaryColor:new Color(0xFFF29494),
  appSecondaryColorLight:new Color(0xFFF2DCDC),
);

final temas = [tema1, tema2, tema3, temaNaranja, temaRojo];

//endregion

class GeneralData {
  static int selectedTheme = 0;
  static Color appStaticMainColor = temas[selectedTheme].appMainColor;

  Color appMainColor = appStaticMainColor;
  Color appMainColorLight = temas[selectedTheme].appMainColorLight;
  Color appMainColorDark = temas[selectedTheme].appMainColorDark;
  Color appSecondaryColor = temas[selectedTheme].appSecondaryColor;
  Color appSecondaryColorLight = temas[selectedTheme].appSecondaryColorLight;

  int currentHighScore=0; //debe guardarse el highscore
  bool isCurrentRecordBeated=false;


  static Map<int, Color> color =
  {
    50:appStaticMainColor.withOpacity(.1),
    100:appStaticMainColor.withOpacity(.2),
    200:appStaticMainColor.withOpacity(.3),
    300:appStaticMainColor.withOpacity(.4),
    400:appStaticMainColor.withOpacity(.5),
    500:appStaticMainColor.withOpacity(.6),
    600:appStaticMainColor.withOpacity(.7),
    700:appStaticMainColor.withOpacity(.8),
    800:appStaticMainColor.withOpacity(.9),
    900:appStaticMainColor.withOpacity(1),
  };

  MaterialColor colorCustom = MaterialColor(appStaticMainColor.value, color);

  List<int> catchedPokemons = [];
  List<int> encounteredPokemons = [];



  GeneralData._privateConstructor() {
    initializing();
  }

  changePrimaryColor(Color newColor){
    appStaticMainColor=newColor;
    appMainColor = appStaticMainColor;

    appMainColorDark = TinyColor.fromString(CoreHelper.getHexFromColor(newColor)).darken(15).color;
    appMainColorLight= TinyColor.fromString(CoreHelper.getHexFromColor(newColor)).brighten(15).color;

    color =
    {
      50:appStaticMainColor.withOpacity(.1),
      100:appStaticMainColor.withOpacity(.2),
      200:appStaticMainColor.withOpacity(.3),
      300:appStaticMainColor.withOpacity(.4),
      400:appStaticMainColor.withOpacity(.5),
      500:appStaticMainColor.withOpacity(.6),
      600:appStaticMainColor.withOpacity(.7),
      700:appStaticMainColor.withOpacity(.8),
      800:appStaticMainColor.withOpacity(.9),
      900:appStaticMainColor.withOpacity(1),
    };

    colorCustom = MaterialColor(appStaticMainColor.value, color);
    this.generalStore.setThemeColorCustom(colorCustom);
  }

  changeScondaryColor(Color newColor){
    appSecondaryColor=newColor;
    appSecondaryColorLight = TinyColor.fromString(CoreHelper.getHexFromColor(newColor)).brighten(15).color;

    color =
    {
      50:appStaticMainColor.withOpacity(.1),
      100:appStaticMainColor.withOpacity(.2),
      200:appStaticMainColor.withOpacity(.3),
      300:appStaticMainColor.withOpacity(.4),
      400:appStaticMainColor.withOpacity(.5),
      500:appStaticMainColor.withOpacity(.6),
      600:appStaticMainColor.withOpacity(.7),
      700:appStaticMainColor.withOpacity(.8),
      800:appStaticMainColor.withOpacity(.9),
      900:appStaticMainColor.withOpacity(1),
    };

    colorCustom = MaterialColor(appStaticMainColor.value, color);
    this.generalStore.setThemeColorCustom(colorCustom);
  }

  changeTheme(int number){
    selectedTheme=number;
    appStaticMainColor = temas[selectedTheme].appMainColor;

    appMainColor = appStaticMainColor;
    appMainColorLight = temas[selectedTheme].appMainColorLight;
    appMainColorDark = temas[selectedTheme].appMainColorDark;
    appSecondaryColor = temas[selectedTheme].appSecondaryColor;
    appSecondaryColorLight = temas[selectedTheme].appSecondaryColorLight;

    color =
    {
      50:appStaticMainColor.withOpacity(.1),
      100:appStaticMainColor.withOpacity(.2),
      200:appStaticMainColor.withOpacity(.3),
      300:appStaticMainColor.withOpacity(.4),
      400:appStaticMainColor.withOpacity(.5),
      500:appStaticMainColor.withOpacity(.6),
      600:appStaticMainColor.withOpacity(.7),
      700:appStaticMainColor.withOpacity(.8),
      800:appStaticMainColor.withOpacity(.9),
      900:appStaticMainColor.withOpacity(1),
    };

    colorCustom = MaterialColor(appStaticMainColor.value, color);
    this.generalStore.setThemeColorCustom(colorCustom);
  }

  initializing() async {
    generalStore.userSettings = new Settings();

    await ApiClient.fetchCatchedPokemon().then((value) {
      catchedPokemons = value;
    });

    await ApiClient.loadUserSettings().then((value){
      if (value==null){
        generalStore.userSettings.language=Languages.English;
        generalStore.userSettings.imagestype = ImagesTypes.HDImages;
        generalStore.userSettings.theme=tema1;
      }else{
      }
    });

    generalStore.setInitializingState(false);
  }

  static final GeneralData _instance = GeneralData._privateConstructor();
  final generalStore = _GeneralStore();

  static GeneralData get instance {
    return _instance;
  }
}
