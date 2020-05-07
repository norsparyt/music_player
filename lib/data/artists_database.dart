import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:music_player_prototype/model/singers.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();

  factory DBHelper() => _instance;

  final String tableSinger = "singerTable";
  final String columnId = "id";
  final String columnName = "name";
  final String columnNumberSongs = "numberSongs";
  final String columnNumberAlbums = "numberAlbums";
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DBHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
        documentDirectory.path, "artists.db"); //home://directory/files/maindb.db

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
        "CREATE TABLE $tableSinger($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnNumberAlbums TEXT,$columnNumberSongs TEXT)");
  }

  //CRUD - CREATE, READ, UPDATE , DELETE

  //Insertion
  Future<int> saveSinger(Singer singer) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableSinger", singer.toMap());
    return res;
  }

  //Get Singers
  Future<List> getAllSingers() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableSinger");

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM $tableSinger"));
  }

  Future<Singer> getSinger(int id) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM $tableSinger WHERE $columnId = $id");
    if (result.length == 0) return null;
    return new Singer.fromMap(result.first);
  }

  Future<int> deleteSinger(int id) async {
    var dbClient = await db;

    return await dbClient.delete(tableSinger,
        where: "$columnId = ?", whereArgs: [id]);
  }


  Future<int> updateSinger(Singer singer) async {
    var dbClient = await db;
    return await dbClient.update(tableSinger,
        singer.toMap(), where: "$columnId = ?", whereArgs: [singer.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }


}
