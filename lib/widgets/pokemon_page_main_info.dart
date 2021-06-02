import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/core/helpers/pokemon_helper.dart';
import 'package:myapp/core/models/pokemon_pokedex.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:myapp/widgets/pokemon_type_label.dart';

final boxDecorationGradient = new LinearGradient(
// Where the linear gradient begins and ends
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
// Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 1],
  colors: [
// Colors are easy thanks to Flutter's Colors class.
    Color.fromRGBO(220, 220, 220, 1),
    Color.fromRGBO(240, 240, 240, 1),
  ],
);
final textShadows = [
  Shadow(
      // bottomLeft
      offset: Offset(-1, -1),
      color: Colors.black),
  Shadow(
      // bottomRight
      offset: Offset(1, -1),
      color: Colors.black),
  Shadow(
      // topRight
      offset: Offset(1, 1),
      color: Colors.black),
  Shadow(
      // topLeft
      offset: Offset(-1, 1),
      color: Colors.black),
];

class PokedexPageMainInfo extends StatelessWidget {
  PokemonPokedex pokemon;

  PokedexPageMainInfo(this.pokemon, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BorderedText(
            strokeWidth: 4.0,
            strokeColor: Colors.black,
            child: Text(
              "#${pokemon.id.toString().padLeft(3, "0")}",
              style: TextStyle(
                  fontFamily: "Roboto", fontSize: 17, color: Colors.white),
            ),
          ),
          BorderedText(
            strokeWidth: 4.0,
            strokeColor: Colors.black,
            child: Text(
              "${pokemon.name[0].toUpperCase() + pokemon.name.substring(1)}",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 26,
                  color: Colors.white,
                  shadows: textShadows),
            ),
          ),
          BorderedText(
            strokeWidth: 4.0,
            strokeColor: Colors.black,
            child: Text(
              "${pokemon.subName}",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 17,
                  color: Colors.white,
                  shadows: textShadows),
            ),
          ),
          PokedexPageMainInfoTypes(pokemon.types),
          BorderedText(
            strokeWidth: 4.0,
            strokeColor: Colors.black,
            child: Text(
              "Height: ${pokemon.height / 10} m",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 17,
                  color: Colors.white,
                  shadows: textShadows),
            ),
          ),
          BorderedText(
            strokeWidth: 4.0,
            strokeColor: Colors.black,
            child: Text(
              "Weight: ${pokemon.weight / 10} kg",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 17,
                  color: Colors.white,
                  shadows: textShadows),
            ),
          ),
        ],
      ),
    );
  }
}

class PokedexPageMainInfoTypes extends StatelessWidget {
  List<PokemonTypes> types;

  PokedexPageMainInfoTypes(this.types, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    List<Widget> widgetList = [];

    for (int i = 0; i < this.types.length; i++) {
      widgetList.add(PokemonTypeLabel(
        this.types[i],
        true,
        size: 0,
      ));
    }

    return Container(
      padding: EdgeInsets.only(left: 0, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widgetList,
      ),
    );
  }
}

class PokedexPageIconSection extends StatelessWidget {
  PokemonPokedex pokemon;

  PokedexPageIconSection(this.pokemon, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Tooltip(
            message: "Capture rate",
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/pokeball_icon.svg",
                  height: 15,
                  color: Colors.red,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: Text(
                    "${(pokemon.captureRate).toString()}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Tooltip(
            message: "Base friendship",
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/heart.svg",
                  height: 15,
                  color: Colors.red,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: Text(
                    "${(pokemon.baseHappines).toString()}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Tooltip(
            message: "Steps to hatch",
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/egg.svg",
                  height: 15,
                  color: Colors.green,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: Text(
                    "${(pokemon.stepToHatchEgg).toString()}",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Tooltip(
            message: "Male % rate",
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/male_symbol.svg",
                  height: 15,
                  color: Colors.blue,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: Text(
                    pokemon.getMaleRate() == 0
                        ? "---"
                        : "${(pokemon.getMaleRate()).toString()}%",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Tooltip(
            message: "Female % rate",
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/female_symbol.svg",
                  height: 15,
                  color: Colors.pinkAccent,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 10),
                  child: Text(
                    pokemon.getFemaleRate() == 0
                        ? "---"
                        : "${(pokemon.getFemaleRate()).toString()}%",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PokedexPageDescription extends StatelessWidget {
  PokemonPokedex pokemon;

  PokedexPageDescription(this.pokemon, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 5, top: 10),
      child: Text(
        pokemon.description.replaceAll("\n", " "),
        style:
            TextStyle(fontSize: 18, fontFamily: "Roboto", color: Colors.black),
      ),
    );
  }
}

class PokedexPageBox extends StatelessWidget {
  Widget widget;

  PokedexPageBox(this.widget, {Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 10.0),
      child: this.widget,
    );
  }
}
