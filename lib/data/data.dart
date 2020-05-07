import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player_prototype/data/artists_database.dart';
import 'package:music_player_prototype/model/imageCards.dart';
import 'package:music_player_prototype/model/cards.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player_prototype/data/database_helper.dart';
import 'package:music_player_prototype/model/song.dart';

final FlutterAudioQuery audioQuery = FlutterAudioQuery();

final all = imageCards(imageUrl: "images/space.jpg", text: "All tracks");
final favs = imageCards(imageUrl: "images/favzz.jpg", text: "Favourites");
final playlists = imageCards(imageUrl: "images/folders.jpg", text: "Playlists");
final albums= imageCards(imageUrl:"images/alone.jpg",text: "Albums" );
final artists= imageCards(imageUrl:"images/guitar.jpg",text: "Artists" );
final genres= imageCards(imageUrl:"images/casette.jpg",text: "Genres" );
final List<imageCards> recentsList = [all, favs, playlists,albums,artists,genres];


final keepListening = cards(title: "Keep listening");
final artistsCard = cards(title: "Explore");
final List<cards> cardsList = [keepListening, artistsCard];

/*albums has max year , artist, mun year, albumname , id, number of songs*/
/*artists has artist , no of albums ,no of songs,*/

Image img = Image.asset('images/nn.png');

var db = new DatabaseHelper();
//List _songs;
var dbSinger= new DBHelper();
//Future<String> getTitleFromDatabase(int index)
//async {
//  Song temp = await db.getSong(index);
//  return temp.title;
//}
//Future<String> getPathFromDatabase(int index)
//async {
//  Song temp = await db.getSong(index);
//  return temp.path;
//}
int count;
List<bool> myList = List<bool>(count);

void crud() async {
//  List<SongInfo> songs = await audioQuery.getSongs();
//  File f = new File(songs[200].filePath);
//  for(int i=0;i<songs.length;i++)
// { await db.saveSong(
//      Song(songs[i].title, songs[i].filePath, int.parse(songs[i].id), songs[i].album, songs[i].artist , songs[i].duration,songs[i].albumArtwork));
//}
//Add song

////  Retrieving a song
//  Song temp = await db.getSong(345);
//  print(temp.path);
//  Song updatedTemp = Song.fromMap({
//    "username": "UpdatedAna",
//    "password" : "updatedPassword",
//    "id"       : 1
//  });
////  Update
//  await db.updateSong(anaUpdated);

  //Delete a Song

//   //count
//   await db.deleteSong(1223);
//  print("Delete Song:  $songDeleted");

//  List<ArtistInfo> artists = await audioQuery.getSongsFromArtist(artist: null);
//  print(artists[100].);
//  for(int i=0;i<artists.length;i++)
//  await dbSinger.saveSinger(Singer(name: artists[i].name, numberAlbums:artists[i].numberOfAlbums , numberSongs: artists[i].numberOfTracks));
//Add song


//for(int i=0; i<count;i++)
//  {
//    await db.deleteSong(3303);
//  print("Deleted Song");
//  }
//print("DONEEEE");
  count = await db.getCount();
  print("Count: $count");
//  Get all songs;
//  var _songs = await db.getAllSongs();
//  for (int i = 0; i < _songs.length; i++) {
//    Song song = Song.map(_songs[i]);
//    print(" Id: ${song.id},Title: ${song.title },"
////        "Name Album: ${song.albumName},artist Name: ${song.artistName} ,"
//        "duration: ${song
//        .duration},path:${song.path},albumArtwork:${song.art}");
//  }

//updateList()
//async {
//  List<SongInfo> songs = await audioQuery.getSongs();
//  for(int i=0;i<songs.length;i++)
//  await db.saveSong(Song(songs[i].title,songs[i].filePath));
//  print("UPDATING DONE");
//}


//yeah() async {
//      List<SongInfo> finalList = await audioQuery.getSongs();
//      TagProcessor tp = new TagProcessor();
//      File f = new File(finalList[200].filePath);
////      dynamic l = await tp.getTagsFromByteArray(f.readAsBytes());
////      AttachedPicture ap = (l[1].tags['picture']);
////      print(ap.imageData64);
////      Image imag = Image.memory(base64Decode(ap.imageData64));
////      setState(() {
////        circleImage=imag;
////      });
//////      print(l[0]);
//////      print(l[1]);
////
//////    if(l[0].tags!=null) {
//////      title = l[0].tags['title'];
//////
//////    }
//////    else{
//////        title="null";
//////        thisone=img;
////
//      tp.getTagsFromByteArray(File(finalList[i].filePath).readAsBytes()).then((
//          l) {
//        thislist[i][0]=l[1].tags['title'];
//          thislist[i][1]=Image.memory(base64Decode((l[1].tags['picture']).imageData64)).image;
//        });
//      lst[i] = {"title": title,
//        "image": thisone.image
//    };
//
////    }
////    print("done");
//  }

}