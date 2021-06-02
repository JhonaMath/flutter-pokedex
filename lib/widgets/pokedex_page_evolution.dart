import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/core/apiModels/apiPokemonEvolutionChain.dart';
import 'package:myapp/core/generalState.dart';

class PokedexPageEvoltion extends StatelessWidget {
  EvolutionNode evolutionNode;
  Color color;

  PokedexPageEvoltion(this.evolutionNode, this.color, {Key key})
      : super(key: key);

  Widget evolutionRow(int index) {
    List<int> listaEvos = evolutionNode.getEvolutionId(index + 1);

    List<Widget> rows = [];

    for (int i = 0; i < listaEvos.length; i++) {

      bool shadowedLeftImage = GeneralData.instance.encounteredPokemons.contains(evolutionNode.getEvolutionId(index)[0]);

      bool shadowedRightImage = GeneralData.instance.encounteredPokemons.contains((listaEvos[i]));

      rows.add(Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Image.network(
                GeneralData.instance.generalStore.getImageUrlById((evolutionNode.getEvolutionId(index)[0]), ImagesTypes.HDImages),
                fit: BoxFit.fill,
                color: shadowedLeftImage?Colors.black:null,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: SvgPicture.asset(
                "assets/arrow-red.svg",
                color: this.color,
                fit: BoxFit.fill,
                height: 30,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Image.network(
                GeneralData.instance.generalStore.getImageUrlById((listaEvos[i]), ImagesTypes.HDImages),
                fit: BoxFit.fill,
                color: shadowedRightImage?Colors.black:null,
              ),
            ),
          ),
        ],
      ));
      rows.add(Divider(color: Colors.black,),);
    }

    return Column(
      children: rows,
    );
  }

  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        this.evolutionRow(0),
        this.evolutionRow(1),

//        this.evolutionRow(1),
      ],
    ));
  }
}
