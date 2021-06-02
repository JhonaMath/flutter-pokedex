abstract class Character {
  int _id;
  String _name;
  String _imageURL;

  Character.Empty();

  Character(this._id, this._name, this._imageURL);

  Character.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _imageURL = json['email'];

  String get imageURL {
    return this._imageURL;
  }

  set imageURL(value){
    this._imageURL=value;
  }


  String get name {
    return this._name;
  }

  set name(value){
    this._name=value;
  }

  int get id {
    return this._id;
  }

  set id(value){
    this._id=value;
  }
}