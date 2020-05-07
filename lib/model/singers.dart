class Singer{
//  final String imageUrl;
   int id;
   String name;
   String numberAlbums;
   String numberSongs;
   Singer({this.id,this.name,this.numberAlbums,this.numberSongs});

   Singer.map(dynamic obj) {
     this.name = obj['name'];
     this.numberAlbums = obj['numberAlbums'];
     this.numberSongs = obj['numberSongs'];
     this.id=obj['id'];
   }


   Map<String,dynamic> toMap(){
    var map=<String ,dynamic>{
      'id':id,
      'name':name,
      'numberAlbums':numberAlbums,
      'numberSongs':numberSongs
    };
    return map;
  }
  Singer.fromMap(Map<String,dynamic> map){
    id=map['id'];
    name=map['name'];
    numberAlbums=map['numberAlbums'];
    numberSongs=map['numberSongs'];
  }
}