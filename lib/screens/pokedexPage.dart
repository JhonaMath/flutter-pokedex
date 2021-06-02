import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/generalState.dart';
import 'package:myapp/core/helpers/pokemon_helper.dart';
import 'package:myapp/core/models/pokemon_pokedex.dart';
import 'package:myapp/widgets/pokedex_page_sprites.dart';
import 'package:myapp/widgets/pokedex_page_tab.dart';
import 'package:myapp/widgets/pokemon_page_main_info.dart';

import 'loading.dart';

class PokedexPageArguments {
  int number;

  PokedexPageArguments(this.number);
}

class PokedexPage extends StatefulWidget {
  static ScrollController controller = ScrollController();

  @override
  _PokedexPage createState() => _PokedexPage();
}

class _PokedexPage extends State<PokedexPage> {
  PokemonPokedex pokemon = null;
  PokedexPageArguments args;

  void findPoke() {
    if (pokemon == null) {
      GeneralData.instance.generalStore
          .fetchPokemonPokedex(args.number)
          .then((onValue) {
        setState(() {
          pokemon = onValue;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    this.findPoke();

    return pokemon == null
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: BorderedText(
                strokeColor: Colors.black,
                strokeWidth: 3.0,
                child: Text(
                    "#${args.number.toString().padLeft(3, "0")} ${pokemon.name[0].toUpperCase() + pokemon.name.substring(1)}"),
              ),
              backgroundColor:
                  pokemonTypeColor[pokemon.types[0]].withAlpha(255),
            ),
            body: Container(
              color: Colors.white,
              height: double.infinity,
              child: SingleChildScrollView(
                controller: PokedexPage.controller,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
// Where the linear gradient begins and ends
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
// Add one stop for each color. Stops should increase from 0 to 1
                                stops: [0.1, 0.7],
                                colors: pokemon.types.length > 1
                                    ? [
                                  pokemonTypeColor[pokemon.types[0]],
                                  pokemonTypeColor[pokemon.types[1]]
                                ]
                                    : [
                                  pokemonTypeColor[pokemon.types[0]],
                                  pokemonTypeColor[pokemon.types[0]]
                                ]),
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 210,
                                        padding: EdgeInsets.all(5.0),
                                        child: Center(
                                          child: PokedexPokemonSprites(
                                              pokemon.sprites, pokemon.types),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 210,
                                        padding: EdgeInsets.only(
                                            left: 5, top: 5, bottom: 5),
                                        child: PokedexPageMainInfo(pokemon),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)),
                                  ),
                                  child: PokedexPageIconSection(pokemon),
                                ),
                              ],
                            ),
                          )),
                      PokedexPageBox(PokedexPageDescription(pokemon)),
                      Divider(),
                      PokedexPageBox(
                        PokedexPageTabs(pokemon),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
