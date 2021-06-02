import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:myapp/core/models/pokemon_pokedex.dart';

class PokedexPageAbilities extends StatelessWidget {

  List<PokemonAbility> abilities;

  PokedexPageAbilities( this.abilities, {Key key})
      : super(key: key);

  Widget renderAbility(PokemonAbility ability){
    return ExpansionTile(
      key: PageStorageKey<int>(ability.id),
      title: Text(ability.name + (ability.isHidden?" (Hidden)":""),),
      children: [
        Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 10.0),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(ability.description),
            ],
          ),
        ),

      ],
    );
  }

  Widget build(BuildContext context) {

    List<Widget> listWidget = [];

    this.abilities.sort((a, b){
      return a.isHidden?1:0;
    });

    for (int i=0; i<this.abilities.length;i++){
      listWidget.add(this.renderAbility(this.abilities[i]));
    }
    return Column(
      children: listWidget,
    );
  }
}
