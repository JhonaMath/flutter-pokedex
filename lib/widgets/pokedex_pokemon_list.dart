import 'package:flutter/material.dart';
import 'package:myapp/core/generalState.dart';
import 'package:myapp/core/helpers/pokemon_helper.dart';
import 'package:myapp/screens/pokedex.dart';
import 'package:myapp/widgets/pokedex_pokemon.dart';

class PokedexPokemonList extends StatelessWidget {
  final PokedexFilter filter;
  final List<int> generation;
  PokedexPokemonList( this.filter, this.generation, {Key key}) : super(key: key);

  bool _shouldAddPokemon(int id){
    if (generation.isNotEmpty){
      bool shouldShow=generation.any((gen){
        return id>pokemonGeneration[gen-1] && id<=pokemonGeneration[gen];
      });
      return shouldShow;
    }else{
      return true;
    }
  }

  List<int> _getPokeListByFilter(){
    List<int> listaPokes=[];

    if (filter==PokedexFilter.ALL){
      if (generation.isNotEmpty){
        for(int i=0; i<generation.length;i++){
          for (int j=(pokemonGeneration[generation[i]-1]+1); j<=pokemonGeneration[generation[i]]; j++){
            listaPokes.add(j);
          }
        }
      }else{
        listaPokes=List.generate(898, (i)=>i+1);
      }
    }else if(filter==PokedexFilter.CATCHED){
      GeneralData.instance.catchedPokemons.forEach((i){
        if (_shouldAddPokemon(i)){
          listaPokes.add(i);
        }
      });
    }else if(filter==PokedexFilter.ENCOUNTERED){
      GeneralData.instance.encounteredPokemons.forEach((i){
        if (_shouldAddPokemon(i)){
          listaPokes.add(i);
        }
      });
    }else if(filter==PokedexFilter.CATCHEDANDENCOUNTERED){
      GeneralData.instance.catchedPokemons.forEach((i){
        if (_shouldAddPokemon(i)){
          listaPokes.add(i);
        }
      });
      GeneralData.instance.encounteredPokemons.forEach((i){
        if (_shouldAddPokemon(i)){
          listaPokes.add(i);
        }
      });
    }

    listaPokes.sort();
    return listaPokes;
  }

  Widget build(BuildContext context) {

    List<int> listaPokes=_getPokeListByFilter();

    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(listaPokes.length, (index) {
        int realId=-1;
        realId = listaPokes[index];
        return Container(
          padding: EdgeInsets.all(3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Material(
                      elevation:2,
                      child:  Container(
                          child: Center(
                            child: PokedexPokemon(realId, true),
                          )),
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
