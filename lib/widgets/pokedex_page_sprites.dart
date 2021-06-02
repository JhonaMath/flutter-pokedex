
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/helpers/pokemon_helper.dart';

class PokedexPokemonSprites extends StatefulWidget {

  final List<String> sprites;
  final List<PokemonTypes> types;

  PokedexPokemonSprites(this.sprites, this.types,{Key key}) : super(key: key);

  @override
  _PokedexPokemonSprites createState() => _PokedexPokemonSprites();

}

class _PokedexPokemonSprites extends State<PokedexPokemonSprites>{

  int spriteIndex=0;

  void _nextImage() {
    setState(() {
      spriteIndex = spriteIndex < widget.sprites.length - 1 ? spriteIndex + 1 : 0;
    });
  }

//  GestureDetector
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _nextImage,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Stack(
                children: <Widget>[
                    Container(
                      height:200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl:
                        widget.sprites[spriteIndex],
                        placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        new Icon(Icons.error),
                      ),
                  ),
                  Positioned(
                    left: 25.0,
                    right: 25.0,
                    bottom: 10.0,
                    child: SelectedPhoto(numberOfDots: widget.sprites.length, photoIndex: spriteIndex),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedPhoto extends StatelessWidget {

  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(
        child: new Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4.0)
            ),
          ),
        )
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.0,
                    blurRadius: 2.0
                )
              ]
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for(int i = 0; i< numberOfDots; ++i) {
      dots.add(
          i == photoIndex ? _activePhoto(): _inactivePhoto()
      );
    }

    return dots;
  }


  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
