// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_null_comparison

class Note {
  //variables for database field
  int _id = 0;
  String _title;
  String _description;
  String _date;
  int _priority;

  //constructor

  Note(this._title, this._date, this._priority, this._description);

  Note.withId(
      this._id, this._title, this._date, this._priority, this._description);

  //getter
  int get id => _id;
  String get title => _title;
  String get date => _date;
  int get priority => _priority;
  String get description => _description;

  //setter
  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  //cover a Note object into a map object

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = _id;
    }
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;

    return map;
  }

  //Extract a Note object from a Map object
  fromMapObject(Map<String, dynamic> map) {
    this._id = map["id"];
    this._date = map["date"];
    this._description = map["description"];
    this._title = map["title"];
    this._priority = map["priority"];
  }
}
