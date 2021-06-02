

import 'dart:math';

import 'dart:ui';

class CoreHelper{

  static String getHintLetterRandom(String word){
    String auxStr = word.toLowerCase();
    String comodin="|", comodin2="+";
    Map<String, int> map = new Map<String, int>();
    List<String> listStr = [];

    for (int i = 0; i < word.length; i++) {
      if (!map.containsKey(word[i].toLowerCase())) {
        map[word[i].toLowerCase()]=1;
        listStr.add(word[i].toLowerCase());
      }else{
        map[word[i].toLowerCase()]++;
      }
    }

    listStr.sort((a,b){
      if (map[a]>map[b]){
        return 1;
      }else{
        return 0;
      }
    });

    for(int i=0; i<(listStr.length/2).floor();i++){
      auxStr=auxStr.replaceAll(listStr[i], comodin);
      auxStr=auxStr.replaceAll(listStr[listStr.length-i-1], comodin2);
      auxStr=auxStr.replaceAll(comodin, listStr[listStr.length-i-1]);
      auxStr=auxStr.replaceAll(comodin2, listStr[i]);
    }

    Random rnd = new Random();
    return auxStr[rnd.nextInt(auxStr.length)];
  }

  static String getHexFromColor(Color color){
    return "#${color.red.toRadixString(16).padLeft(2, "0")}"
        "${color.green.toRadixString(16).padLeft(2, "0")}"
        "${color.blue.toRadixString(16).padLeft(2, "0")}";
  }

}