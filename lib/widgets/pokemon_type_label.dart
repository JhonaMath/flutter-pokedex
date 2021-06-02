import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/helpers/pokemon_helper.dart';

class PokemonTypeLabel extends StatelessWidget {
  PokemonTypes type;
  bool visible;
  int size=0;

  PokemonTypeLabel(this.type, this.visible, {Key key, this.size:0}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: this.visible
              ? pokemonTypeColor[this.type].withAlpha(255)
              : Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          )),
      height: this.size==0?25:40,
      width: this.size==0?75:120,
      child: this.visible
          ? Center(
              child: BorderedText(
                strokeWidth: 4.0,
                strokeColor: Colors.black,
                child: Text(
                  pokemonTypeToString[this.type].toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: this.size==0?14:20,
                      fontFamily: "Roboto",
                      decoration: TextDecoration.none),
                ),
              ),
            )
          : Container(),
    );
  }
}
