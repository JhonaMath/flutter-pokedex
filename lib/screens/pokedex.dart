import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:myapp/core/generalState.dart';
import 'package:myapp/widgets/pokedex_pokemon_list.dart';
import 'package:myapp/screens/loading.dart';


enum PokedexFilter { ALL, CATCHED, ENCOUNTERED, CATCHEDANDENCOUNTERED }

class PokedexScreen extends StatefulWidget {
  @override
  _PokedexScreen createState() => _PokedexScreen();
}

class _PokedexScreen extends State<PokedexScreen> {
  PokedexFilter filter = PokedexFilter.CATCHEDANDENCOUNTERED;
  int imageTypeIndex = 0;

  List<int> generation = [];

  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (GeneralData.instance.generalStore.initializing)
        return LoadingScreen();
      else return Scaffold(
        appBar: AppBar(
          title: Text("Pokedex"),
          actions: <Widget>[

            IconButton(
              icon: GeneralData.instance.generalStore.userSettings.language==Languages.English?Image.asset("assets/en_flag.png"):Image.asset("assets/es_flag.png"),
              onPressed: () {
                GeneralData.instance.generalStore.userSettings.language=GeneralData.instance.generalStore.userSettings.language==Languages.English ? Languages.Spanish : Languages.English;

                setState(() {
                  imageTypeIndex= (imageTypeIndex+1) % 3;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.switch_account_outlined),
              onPressed: () {
                GeneralData.instance.generalStore.userSettings.imagestype=ImagesTypes.values[imageTypeIndex];
                setState(() {
                  imageTypeIndex= (imageTypeIndex+1) % 3;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                _filterModalBottomSheet(context);
              },
            ),
          ],
        ),
        body: Container(
          color: Color.fromRGBO(242, 243, 255, 1),
          child: PokedexPokemonList(filter, generation),
        ),
      );
    });
  }

  void _filterModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                  generationFilterSelector(context),
                ]),
              ],
            ),
          );
        });
  }

  Widget catchedFilterSelector() {
    return Expanded(
      flex: 1,
        child:Container(
          decoration: BoxDecoration(
            color: GeneralData.instance.appMainColor,
            border: Border.all(
                width: 2.0,
                color: Colors.black),
          ),
          padding: new EdgeInsets.all(20),
          child: ElevatedButton(
            child: Text("Catched"),
            onPressed: (){
              _showCatchedFilterDialog(context);
            },

          ),
        )
    );
  }

  Widget generationFilterSelector(context) {
    return Expanded(
        flex: 1,
        child:Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 2.0,
                color: Colors.black),
            ),
          padding: new EdgeInsets.all(10),
          child: ElevatedButton(
            child: Text("Generations"),
            onPressed: (){
              _showGenerationSelectionDialog(context);
            },

          )
        )
    );
  }

  void addGeneration(int number){
    setState(() {
      generation.add(number);
      generation.sort();
    });
  }

  void removeGeneration(int number){
    setState(() {
      generation.remove(number);
    });
  }

  void changeFilter(PokedexFilter value){
    setState(() {
      filter=value;
    });
  }

  void _showCatchedFilterDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        return CatchedFilterDialogContent(filter: filter, changeFilter: changeFilter,);
      },
    );
  }

  // user defined function
  void _showGenerationSelectionDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        return GenerationSelectionDialogContent(generation: generation, addGeneration: addGeneration, removeGeneration: removeGeneration,);
      },
    );
  }
}

class CatchedFilterDialogContent extends StatefulWidget {
  PokedexFilter filter;
  final void Function(PokedexFilter) changeFilter;

  CatchedFilterDialogContent({
    Key key,
    this.filter,
    this.changeFilter
  }): super(key: key);

  @override
  _CatchedFilterDialogContent createState() => _CatchedFilterDialogContent();
}

class _CatchedFilterDialogContent extends State<CatchedFilterDialogContent> {

  int radioGroupValue;

  @override
  void initState() {
    super.initState();
    radioGroupValue=widget.filter.index;
  }

  void handlerRadioButtonChange(value){
    setState(() {
      radioGroupValue=value;
      widget.changeFilter(PokedexFilter.values[value]);
    });
  }

  Widget build(BuildContext context){

    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      title: new Text("Generation Filter"),
      content: Wrap(
        children: <Widget>[
          Column(
            children:[
              Row(
                children: <Widget>[
                  new Radio(
                    value: 1,
                    groupValue: radioGroupValue,
                    onChanged: handlerRadioButtonChange,
                  ),
                  Text("Catched")
                ],
              ),
              Row(
                children: <Widget>[
                  new Radio(
                    value: 2,
                    groupValue: radioGroupValue,
                    onChanged: handlerRadioButtonChange,
                  ),
                  Text("Not Catched")
                ],
              ),
              Row(
                children: <Widget>[
                  new Radio(
                    value: 3,
                    groupValue: radioGroupValue,
                    onChanged: handlerRadioButtonChange,
                  ),
                  Text("Catched and Not Catched")
                ],
              ),
            ]
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class GenerationSelectionDialogContent extends StatefulWidget {
  List<int> generation = [];
  final void Function(int) addGeneration;
  final void Function(int) removeGeneration;

  GenerationSelectionDialogContent({
    Key key,
    this.generation,
    this.addGeneration,
    this.removeGeneration
  }): super(key: key);

  @override
  _GenerationSelectionDialogContent createState() => _GenerationSelectionDialogContent();
}

class _GenerationSelectionDialogContent extends State<GenerationSelectionDialogContent> {

  List<String> generationString=["1sr Generation", "2nd Generation", "3rd Generation", "4th Generation", "5th Generation", "6th Generation", "7th Generation", "8th Generation"];

  Widget build(BuildContext context){
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      title: new Text("Generation Filter"),
      content: Wrap(
        children: <Widget>[
          Column(
            children:
            generationString.map((String text){
              return CheckboxListTile(
                title: Text(text),
                value: widget.generation.contains(generationString.indexOf(text)+1),
                onChanged: (newValue) {
                  int index=generationString.indexOf(text)+1;
                  if (newValue){
                    setState(() {
                      widget.addGeneration(index);
                    });
                  }else{
                    setState(() {
                      widget.removeGeneration(index);
                    });
                  }
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              );
            }).toList(),
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
