import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/helpers/pokemon_helper.dart';
import 'package:myapp/core/models/pokemon_pokedex.dart';

import 'package:myapp/widgets/pokedex_page_abilities.dart';
import 'package:myapp/widgets/pokedex_page_evolution.dart';
import 'package:myapp/widgets/pokedex_page_stats_chart.dart';

enum OptionsPokedexPageTabs { STATS, EVOLUTION, ABILITIES, MOVES }

class PokedexPageTabs extends StatefulWidget {
  PokemonPokedex pokemon;

  PokedexPageTabs(this.pokemon, {Key key}) : super(key: key);

  @override
  _PokedexPageTabs createState() => _PokedexPageTabs();
}

class _PokedexPageTabs extends State<PokedexPageTabs> {
  OptionsPokedexPageTabs optionSelected;

  _PokedexPageTabs() {
    optionSelected = OptionsPokedexPageTabs.STATS;
  }

  handleTapTab(OptionsPokedexPageTabs optSelected) {
    setState(() {
      optionSelected = optSelected;
    });
  }

  Widget tab(String text, Color color, OptionsPokedexPageTabs optSelected) {
    return GestureDetector(
      onTap: () {
        this.handleTapTab(optSelected);
      },
      child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Center(
            child: BorderedText(
                strokeColor: Colors.black,
                strokeWidth: 0,
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          )),
    );
  }

  Widget buttonsRow() {
    Color buttonColor =
        pokemonTypeColor[widget.pokemon.types[0]].withAlpha(255);
    Color bottonSelectedColor=pokemonTypeColor[widget.pokemon.types[0]].withAlpha(180);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        this.tab("STATS", this.optionSelected== OptionsPokedexPageTabs.STATS?bottonSelectedColor:buttonColor, OptionsPokedexPageTabs.STATS),
        this.tab("EVOL", this.optionSelected== OptionsPokedexPageTabs.EVOLUTION?bottonSelectedColor:buttonColor, OptionsPokedexPageTabs.EVOLUTION),
        this.tab("ABIL", this.optionSelected== OptionsPokedexPageTabs.ABILITIES?bottonSelectedColor:buttonColor, OptionsPokedexPageTabs.ABILITIES),
//        this.tab("MOVES", this.optionSelected== OptionsPokedexPageTabs.MOVES?bottonSelectedColor:buttonColor, OptionsPokedexPageTabs.MOVES),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        this.buttonsRow(),
        Divider(),
        this.optionSelected == OptionsPokedexPageTabs.STATS
            ? PokedexPageStatsChart(
                widget.pokemon.stats, pokemonTypeColor[widget.pokemon.types[0]])
            : Container(),
        this.optionSelected == OptionsPokedexPageTabs.EVOLUTION?
        PokedexPageEvoltion(widget.pokemon.pokemonEvolution, pokemonTypeColor[widget.pokemon.types[0]])
        :Container(),
        this.optionSelected == OptionsPokedexPageTabs.ABILITIES?
        PokedexPageAbilities(widget.pokemon.abilities)
            :Container(),
      ],
    );
  }
}
