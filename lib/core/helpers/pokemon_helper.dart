import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PokemonTypes {
  BUG,
  DARK,
  DRAGON,
  ELECTRIC,
  FAIRY,
  FIGHTING,
  FIRE,
  FLYING,
  GHOST,
  GRASS,
  GROUND,
  ICE,
  NORMAL,
  POISON,
  PSYCHIC,
  ROCK,
  STEEL,
  WATER,
}

final Map<String, PokemonTypes> stringToPokemonType = {
  "bug": PokemonTypes.BUG,
  "dark": PokemonTypes.DARK,
  "dragon": PokemonTypes.DRAGON,
  "electric": PokemonTypes.ELECTRIC,
  "fairy": PokemonTypes.FAIRY,
  "fighting": PokemonTypes.FIGHTING,
  "fire": PokemonTypes.FIRE,
  "flying": PokemonTypes.FLYING,
  "ghost": PokemonTypes.GHOST,
  "grass": PokemonTypes.GRASS,
  "ground": PokemonTypes.GROUND,
  "ice": PokemonTypes.ICE,
  "normal": PokemonTypes.NORMAL,
  "poison": PokemonTypes.POISON,
  "psychic": PokemonTypes.PSYCHIC,
  "rock": PokemonTypes.ROCK,
  "steel": PokemonTypes.STEEL,
  "water": PokemonTypes.WATER,
};

final Map<PokemonTypes, String> pokemonTypeToString = {
  PokemonTypes.BUG: "bug",
  PokemonTypes.DARK: "dark",
  PokemonTypes.DRAGON: "dragon",
  PokemonTypes.ELECTRIC: "electric",
  PokemonTypes.FAIRY: "fairy",
  PokemonTypes.FIGHTING: "fighting",
  PokemonTypes.FIRE: "fire",
  PokemonTypes.FLYING: "flying",
  PokemonTypes.GHOST: "ghost",
  PokemonTypes.GRASS: "grass",
  PokemonTypes.GROUND: "ground",
  PokemonTypes.ICE: "ice",
  PokemonTypes.NORMAL: "normal",
  PokemonTypes.POISON: "poison",
  PokemonTypes.PSYCHIC: "psychic",
  PokemonTypes.ROCK: "rock",
  PokemonTypes.STEEL: "steel",
  PokemonTypes.WATER: "water",
};

final Map<PokemonTypes, String> pokemonTypeToStringEs = {
  PokemonTypes.BUG: "bicho",
  PokemonTypes.DARK: "siniestro",
  PokemonTypes.DRAGON: "dragon",
  PokemonTypes.ELECTRIC: "electrico",
  PokemonTypes.FAIRY: "hada",
  PokemonTypes.FIGHTING: "lucha",
  PokemonTypes.FIRE: "fuego",
  PokemonTypes.FLYING: "volador",
  PokemonTypes.GHOST: "fantasma",
  PokemonTypes.GRASS: "planta",
  PokemonTypes.GROUND: "tierra",
  PokemonTypes.ICE: "hielo",
  PokemonTypes.NORMAL: "normal",
  PokemonTypes.POISON: "veneno",
  PokemonTypes.PSYCHIC: "psiquico",
  PokemonTypes.ROCK: "roca",
  PokemonTypes.STEEL: "acero",
  PokemonTypes.WATER: "agua",
};

final Map<PokemonTypes, String> pokemonTypeAssetName = {
  PokemonTypes.BUG: "",
  PokemonTypes.DARK: "",
  PokemonTypes.DRAGON: "",
  PokemonTypes.ELECTRIC: "",
  PokemonTypes.FAIRY: "",
  PokemonTypes.FIGHTING: "",
  PokemonTypes.FIRE: "assets/Krunal.png",
  PokemonTypes.FLYING: "",
  PokemonTypes.GHOST: "",
  PokemonTypes.GRASS: "",
  PokemonTypes.GROUND: "",
  PokemonTypes.ICE: "",
  PokemonTypes.NORMAL: "",
  PokemonTypes.POISON: "",
  PokemonTypes.PSYCHIC: "",
  PokemonTypes.ROCK: "",
  PokemonTypes.STEEL: "",
  PokemonTypes.WATER: "",
};

final Map<PokemonTypes, Color> pokemonTypeColor = {
  PokemonTypes.BUG: Color.fromRGBO(168, 184, 32, 0.8),
  PokemonTypes.DARK: Color.fromRGBO(112, 88, 72, 0.8),
  PokemonTypes.DRAGON: Color.fromRGBO(112, 56, 248, 0.8),
  PokemonTypes.ELECTRIC: Color.fromRGBO(248, 208, 48, 0.8),
  PokemonTypes.FAIRY: Color.fromRGBO(238, 153, 172, 0.8),
  PokemonTypes.FIGHTING: Color.fromRGBO(192, 48, 40, 0.8),
  PokemonTypes.FIRE: Color.fromRGBO(240, 128, 48, 0.8),
  PokemonTypes.FLYING: Color.fromRGBO(168, 144, 240, 0.8),
  PokemonTypes.GHOST: Color.fromRGBO(112, 88, 152, 0.8),
  PokemonTypes.GRASS: Color.fromRGBO(120, 200, 80, 0.8),
  PokemonTypes.GROUND: Color.fromRGBO(224, 192, 104, 0.8),
  PokemonTypes.ICE: Color.fromRGBO(152, 216, 216, 0.8),
  PokemonTypes.NORMAL: Color.fromRGBO(168, 168, 120, 0.8),
  PokemonTypes.POISON: Color.fromRGBO(160, 64, 160, 0.8),
  PokemonTypes.PSYCHIC: Color.fromRGBO(248, 88, 136, 0.8),
  PokemonTypes.ROCK: Color.fromRGBO(184, 160, 56, 0.8),
  PokemonTypes.STEEL: Color.fromRGBO(184, 184, 208, 0.8),
  PokemonTypes.WATER: Color.fromRGBO(104, 144, 240, 0.8),
};

final Map<int, int> pokemonGeneration = {
  0: 0,
  1: 151,
  2: 251,
  3: 386,
  4: 493,
  5: 649,
  6: 721,
  7: 807,
  8: 898,
};

int generationForPokemon(int id) {
  for (int generation = 1;
      generation <= pokemonGeneration.length;
      generation++) {
    if (id < pokemonGeneration[generation]) {
      return generation;
    }
  }
  return 0;
}
