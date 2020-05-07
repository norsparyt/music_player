import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:music_player_prototype/model/song.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableSong = "songTable";
  final String columnId = "id";
  final String columnTitle = "title";
  final String columnPath = "path";
  final String columnArtistName = "artistName";
  final String columnAlbumName = "albumName";
  final String columnDuration = "duration";
  final String columnArt="art";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        documentDirectory.path, "maindb.db"); //home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  /*
     id | title | path | baseArtString
     ------------------------
     1  | Paulo    | paulo | slndks
     2  | James    | bond  | kdnskd
   */

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableSong($columnId INTEGER, $columnTitle TEXT, $columnPath TEXT,$columnAlbumName TEXT,$columnArtistName TEXT,$columnDuration TEXT,$columnArt TEXT)");
  }

  //CRUD - CREATE, READ, UPDATE , DELETE

  //Insertion
  Future<int> saveSong(Song song) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableSong", song.toMap());
    return res;
  }

  //Get Songs
  Future<List> getAllSongs() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableSong");

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableSong"));
  }

  Future<Song> getSong(int id) async {
    var dbClient = await db;

    var result = await dbClient
        .rawQuery("SELECT * FROM $tableSong WHERE $columnId = $id");
    if (result.length == 0) return null;
    return new Song.fromMap(result.first);
  }

  Future<int> deleteSong(int id) async {
    var dbClient = await db;

    return await dbClient
        .delete(tableSong, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> updateSong(Song song) async {
    var dbClient = await db;
    return await dbClient.update(tableSong, song.toMap(),
        where: "$columnId = ?", whereArgs: [song.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
