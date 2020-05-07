class Song {
  String _title;
  String _path;
  int _id;
  String _artistName;
  String _albumName;
  String _duration;
  String _art;

  Song(this._title, this._path, this._id, this._albumName, this._artistName,
      this._duration,this._art);

  Song.map(dynamic obj) {
    this._title = obj['title'];
    this._path = obj['path'];
    this._id = obj['id'];
    this._albumName = obj['albumName'];
    this._artistName = obj['artistName'];
    this._duration = obj['duration'];
    this._art= obj['art'];
  }

  String get title => _title;

  String get albumName => _albumName;

  String get path => _path;

  int get id => _id;

  String get artistName => _artistName;

  String get duration => _duration;

  String get art => _art;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = _title;
    map["path"] = _path;
    map["albumName"] = _albumName;
    map["artistName"] = _artistName;
    map["duration"] = _duration;
    map["art"]=_art;

    if (id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Song.fromMap(Map<String, dynamic> map) {
    this._title = map["title"];
    this._path = map["path"];
    this._artistName = map["artistName"];
    this._albumName = map["albumName"];
    this._duration = map["duration"];
    this._id = map["id"];
    this._art= map["art"];
  }
}
