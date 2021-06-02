import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/generalState.dart';
import 'package:myapp/screens/pokedexPage.dart';

enum PokedexStatus { CATCHED, ENCOUNTERED, NONE }

class PokedexPokemon extends StatelessWidget {
  final int id;
  final bool catched;

  PokedexPokemon(this.id, this.catched, {Key key}) : super(key: key);

  Widget pokemonImageWidget(PokedexStatus status){
    var generalStore=GeneralData.instance.generalStore;

    return CachedNetworkImage(
      fit: BoxFit.fitHeight,
      height: generalStore.userSettings.imagestype==ImagesTypes.EightBits? 100:null,
      color: status == PokedexStatus.CATCHED
          ? null
          : Colors.black,
      imageUrl: generalStore.getImageUrlById(id, generalStore.userSettings.imagestype),
      placeholder: (context, url) =>
      new CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
      new Icon(Icons.error),
    );
  }

  Widget build(BuildContext context) {
    var status = PokedexStatus.NONE;
    if (GeneralData.instance.catchedPokemons.contains(id))
      status = PokedexStatus.CATCHED;
    else if (GeneralData.instance.encounteredPokemons.contains(id))
      status = PokedexStatus.ENCOUNTERED;

    return InkWell(
      onTap: status == PokedexStatus.CATCHED?(){Navigator.pushNamed(context, '/pokedex_page', arguments: PokedexPageArguments(id));}:(){},

        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Center(
                              child: Container(
                                  child: Opacity(
                                    opacity: 0.15,
                                    child: Image.asset(
                                      "assets/pokeball.png",
                                      height: 75,
                                    ),
                                  )),
                            ),
                            Center(
                              child: Container(
                                child: status != PokedexStatus.NONE
                                    ? this.pokemonImageWidget(status)
                                    : Image.asset(
                                  "assets/pokeball.png",
                                  height: 75,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Center(
                      child: Text(
                        '#' + (id).toString().padLeft(3, "0"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ))),
    );
  }
}
