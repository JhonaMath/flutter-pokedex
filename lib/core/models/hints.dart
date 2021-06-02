

class Hints {
  bool shadowedPokemon=true;
  bool shadowedGen = true;
  List<bool> typesShadowed=[true,true];
  int letters = 0;

  Hints();

  Hints.from(Hints hint){
    this.shadowedGen=hint.shadowedGen;
    this.typesShadowed=[hint.typesShadowed[0], hint.typesShadowed[1]];
    this.shadowedPokemon=hint.shadowedPokemon;
    this.letters=hint.letters;
  }

}