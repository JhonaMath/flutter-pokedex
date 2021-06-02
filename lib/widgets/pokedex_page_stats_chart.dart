import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';
import 'package:myapp/core/models/pokemon_pokedex.dart';

class PokedexPageStatsChart extends StatefulWidget {
  PokemonStats stats;
  Color color;

  PokedexPageStatsChart(this.stats, this.color, {Key key}) : super(key: key);

  @override
  _PokedexPageStatsChart createState() => new _PokedexPageStatsChart();
}

class _PokedexPageStatsChart extends State<PokedexPageStatsChart> {

  int view=0;

  @override
  Widget renderBar(int value, String text){
    return Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: widget.color.withAlpha(120),
                ),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: value,
              child: Container(
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: widget.color,
                ),

              ),
            ),
            Expanded(
              flex: 255-value,
              child: Container(
                height: 30.0,
                color: Colors.transparent,
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: BorderedText(
              strokeColor: Colors.black,
              strokeWidth: 5.0,
              child: Text(
                text+": " + value.toString(), style: TextStyle(color: Colors.white, fontSize: 14, decoration: TextDecoration.none),),
            ),
          ),
        )

      ],);
  }

  Widget renderBarChart(){
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          this.renderBar(widget.stats.speed, "Speed"),
          Container(margin: EdgeInsets.only(top: 10),),
          this.renderBar(widget.stats.attack, "Atk"),
          Container(margin: EdgeInsets.only(top: 10),),
          this.renderBar(widget.stats.defense, "Def"),
          Container(margin: EdgeInsets.only(top: 10),),
          this.renderBar(widget.stats.specialAttack,"Sp.Atk"),
          Container(margin: EdgeInsets.only(top: 10),),
          this.renderBar(widget.stats.specialDefense, "Sp.Def"),
          Container(margin: EdgeInsets.only(top: 10),),
          this.renderBar(widget.stats.hp,"Hp"),
        ],
      ),
    );
  }

  Widget renderRadarChart(){
    PokemonStats stats=widget.stats;

    return Container(
      color: Colors.white,
      height: 250,
      child: RadarChart(
        values: [
          stats.hp.toDouble(),
          stats.specialAttack.toDouble(),
          stats.specialDefense.toDouble(),
          stats.speed.toDouble(),
          stats.defense.toDouble(),
          stats.attack.toDouble()
        ],
        labels: [
          "HP: ${stats.hp}",
          "Sp.Atk: ${stats.specialAttack}",
          "Sp.Def: ${stats.specialDefense}",
          "Speed: ${stats.speed}",
          "Def: ${stats.defense}",
          "Atk: ${stats.attack}",
        ],
        maxValue: 255,
        animate: false,
        strokeColor: Colors.black,
        textScaleFactor: 0.05,
        fillColor: widget.color,
      ),
    );
  }

  Widget build(BuildContext context) {
    PokemonStats stats=widget.stats;

    int maximo = stats.hp;
    if (maximo < stats.attack) maximo = stats.attack;
    if (maximo < stats.defense) maximo = stats.defense;
    if (maximo < stats.specialDefense) maximo = stats.specialDefense;
    if (maximo < stats.specialAttack) maximo = stats.specialAttack;
    if (maximo < stats.speed) maximo = stats.speed;

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: (){setState(() {
                view=(view+1)%2;
              });},
              child: Container(
                margin: EdgeInsets.only(right: 15, bottom: 10),
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: this.widget.color.withOpacity(0.4),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: widget.color,
                  ),
                  margin: EdgeInsets.only(right: view==0?30:0, left: view==0?0:30),
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            this.view==0?this.renderBarChart():this.renderRadarChart(),
          ],

        ),
      ),
    );
  }
}