
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/core/apiModels/apiPokemonEvolutionChain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apiModels/apiPokemon.dart';
import 'apiModels/apiPokemonAbility.dart';
import 'apiModels/apiPokemonSpecie.dart';

class ApiClient{

  static final baseurlApi="https://pokeapi.co/api/v2/";

  static Map<int,ApiPokemon> cachedPokemon = null;

  static String getPokemonKey(){
    return "pokemon";
  }

  static String getPokemonSpeciesKey(){
    return "pokemonSpecie";
  }

  static String getCatchedPokemonListKey(){
    return "catchedPokemonList";
  }

  static String getPokemonEvolutionKey(){
    return "pokemonEvolution";
  }

  static String getPokemonAbilityKey(){
    return "pokemonAbility";
  }

  static Future<String> _loadCatchedPokemonList() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(ApiClient.getCatchedPokemonListKey());
  }

  static _saveCatchedPokemonList(List<int> listaPokemon) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(ApiClient.getCatchedPokemonListKey(), listaPokemon.toString());
  }

  static String getEncounteredPokemonListKey(){
    return "encounteredPokemonList";
  }

  static _saveEncounteredPokemonList(List<int> listaPokemon) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(ApiClient.getEncounteredPokemonListKey(), listaPokemon.toString());
  }

  //region Pokemon
  static Future<String> _loadCachedPokemon(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ApiClient.getPokemonKey() + id.toString());
  }

  static _saveCachedPokemon(int id, String poke) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(ApiClient.getPokemonKey() + id.toString(), poke);
  }

  static Future<ApiPokemon> fetchPokemon(int id) async {

    var data= await _loadCachedPokemon(id);
    if (data==null){
      http.Client client = http.Client();
      final response =
      await client.get(Uri.parse(baseurlApi + "pokemon/" + id.toString()));
      data=response.body;
      _saveCachedPokemon(id, data);
    }

    Map<String, dynamic> mapResponse = jsonDecode(data);
    return ApiPokemon.fromJson(mapResponse);
    // Use the compute function to run parsePhotos in a separate isolate.
  }

  //endregion

  //region Pokemon Species
  static Future<String> _loadCachedPokemonSpecies(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ApiClient.getPokemonSpeciesKey() + id.toString());
  }

  static _saveCachedPokemonSpecies(int id, String poke) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(ApiClient.getPokemonSpeciesKey() + id.toString(), poke);
  }

  static Future<ApiPokemonSpecie> fetchPokemonSpecie(int id) async {

    var data= await _loadCachedPokemonSpecies(id);
    if (data==null){
      http.Client client = http.Client();
      final response =
      await client.get(Uri.parse(baseurlApi + "pokemon-species/" + id.toString()));
      data=response.body;
      _saveCachedPokemonSpecies(id, data);
    }

    Map<String, dynamic> mapResponse = jsonDecode(data);
    return ApiPokemonSpecie.fromJson(mapResponse);
    // Use the compute function to run parsePhotos in a separate isolate.
  }

  //endregion

  //region Pokemon Evolution
  static Future<String> _loadCachedPokemonEvolution(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ApiClient.getPokemonEvolutionKey() + id.toString());
  }

  static _saveCachedPokemonEvolution(int id, String poke) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(ApiClient.getPokemonEvolutionKey() + id.toString(), poke);
  }

  static Future<ApiPokemonEvolutionChain> fetchPokemonEvolution(int id) async {

    var data= await _loadCachedPokemonEvolution(id);
    if (data==null){
      http.Client client = http.Client();
      final response =
      await client.get(Uri.parse(baseurlApi + "evolution-chain/" + id.toString()));
      data=response.body;
      _saveCachedPokemonEvolution(id, data);
    }

    Map<String, dynamic> mapResponse = jsonDecode(data);

    return ApiPokemonEvolutionChain.fromJson(mapResponse);
    // Use the compute function to run parsePhotos in a separate isolate.
  }
  //endregion

  static Future<String> _loadCachedPokemonAbility(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ApiClient.getPokemonAbilityKey() + id.toString());
  }

  static _saveCachedPokemonAbility(int id, String poke) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(ApiClient.getPokemonAbilityKey() + id.toString(), poke);
  }

  static Future<ApiPokemonAbility> fetchPokemonAbility(int id) async {

    var data= await _loadCachedPokemonAbility(id);
    if (data==null){
      http.Client client = http.Client();
      final response =
      await client.get(Uri.parse(baseurlApi + "ability/" + id.toString()));
      data=response.body;
      _saveCachedPokemonAbility(id, data);
    }

    Map<String, dynamic> mapResponse = jsonDecode(data);

    return ApiPokemonAbility.fromJson(mapResponse);
    // Use the compute function to run parsePhotos in a separate isolate.
  }

  static Future<List<int>> fetchCatchedPokemon() async {

    dynamic list = List.generate(898, (int index){return (index+1);});

    return list;

  }

  static saveCatchedPokemon(List<int> listaPokes){
    _saveCatchedPokemonList(listaPokes);
  }

  static Future<String> loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userSettings");
  }

}