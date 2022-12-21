class className {
  int? ID;
  String? text;
  className(this.text);
  className.WithID(this.ID, this.text);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['ID'] = ID;
    map['text'] = text;
    return map;
  }

  className.fromMap(Map<String, dynamic> map) {
    this.ID = map['ID'];
    this.text = map['text'];
  }
}
