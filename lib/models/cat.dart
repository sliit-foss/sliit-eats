class Cat {
  String _id;
  String _name;
  int _age;
  String _type;

  Cat(this._id, this._name, this._age, this._type);

  Cat.map(dynamic cat) {
    this._id = cat['id'];
    this._name = cat['name'];
    this._age = cat['age'];
    this._type = cat['type'];
  }

  String get id => _id;
  String get name => _name;
  int get age => _age;
  String get type => _type;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['age'] = _age;
    map['type'] = _type;

    return map;
  }

  Cat.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._age = map['age'];
    this._type = map['type'];
  }
}
