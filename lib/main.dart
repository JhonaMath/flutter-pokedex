import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

import 'package:myapp/core/generalState.dart';

import 'package:myapp/screens/pokedex.dart';
import 'package:myapp/screens/pokedexPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp(){
    GeneralData.selectedTheme=0;
    GeneralData.instance;
//    ApiClient.fetchPokemonSpecie(1);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder:(_)=>MaterialApp(
      title: 'Pokedex Flutter',
      initialRoute: "/",
      routes: {
        "/": (context)=>PokedexScreen(),
        "/pokedex_page": (context)=>PokedexPage(),

      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: GeneralData.instance.generalStore.colorCustom,
      ),
      //home: CharacterShadowed(GeneralData.instance.generalStore.currentPokemon)
    ));
  }
}

