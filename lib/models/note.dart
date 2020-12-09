class Note {
  int _id;
  String _name;
  String _number;

  Note(this._name,this._number);
  Note.withId(this._id,this._name,this._number);

  int get id => _id;
  String get name => _name;
  String get number => _number;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }

  }
  set number(String newNumber){
    if (newNumber.length <= 255) {
      this._number = newNumber;
    }

  }


  //Note object to Map object

  Map<String, dynamic> toMap(){

    var map  = Map<String, dynamic>();
    if (id != null){
      map['id'] = _id;
    }
    map['name'] = _name;
    map['number'] = _number;

    return map;


  }
  //Extract note object from Map object

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._number = map['number'];
  }


}