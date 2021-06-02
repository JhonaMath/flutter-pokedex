
class EvolutionNode {
  int number;
  List<EvolutionNode> evolutions = [];

  List<int> getEvolutionId(int height){
    List<int> listId= [];
    if (height==0){
      listId.add(this.number);
    }else{
      for (int i = 0; i<evolutions.length;i++){
        List<int> auxList = evolutions[i].getEvolutionId(height-1);
        for (int j = 0; j<auxList.length;j++){
          listId.add(auxList[j]);
        }
      }
    }
    return listId;
  }

  @override
  String toString() {
    return "$number";
  }
}

class ApiPokemonEvolutionChain {
  EvolutionNode pokemonRoot;

  EvolutionNode evolveToRecursive(evolveTo) {
    EvolutionNode result = new EvolutionNode();
    String url;

    url = evolveTo["species"]["url"];
    url = url.substring(1, url.length - 1);
    result.number = int.parse(url.substring(url.lastIndexOf("/") + 1));

    for (int i = 0; i < evolveTo["evolves_to"].length; i++) {
      result.evolutions.add(evolveToRecursive(evolveTo["evolves_to"][i]));
    }

    return result;
  }

  ApiPokemonEvolutionChain.fromJson(Map<String, dynamic> json) {
    List<dynamic> evolveTo = json["chain"]["evolves_to"];
    //First Case
    String url = json["chain"]["species"]["url"];

    url = url.substring(1, url.length - 1);

    int number = int.parse(url.substring(url.lastIndexOf("/") + 1));

    pokemonRoot = new EvolutionNode();
    pokemonRoot.number = number;

    for (int i = 0; i < evolveTo.length; i++) {
      dynamic pointer = evolveTo[i];
      pokemonRoot.evolutions.add(evolveToRecursive(pointer));
    }
  }

  @override
  String toString() {

    return pokemonRoot.toString();
  }
}
