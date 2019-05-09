import 'dart:async';
import 'dart:io' as io;

import 'package:app2/db/model/moodlog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE MoodLog(id INTEGER PRIMARY KEY, mood TEXT, moodStatus TEXT)");
  }

  Future<int> saveMoodLog(MoodLog moodlog) async {
    var dbClient = await db;
    print(moodlog.toMap());
    int res = await dbClient.insert("MoodLog", moodlog.toMap());
    print(moodlog.toMap());
    print("Saved Mood log");
    print(numberOfLogs());
    return res;
  }

  Future<int> numberOfLogs() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Moodlog');
    return list.length;
  }

  Future<List<MoodLog>> getMoodLog() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Moodlog');
    List<MoodLog> moodlogs = new List();
    print("list length is : ");
    print(list.length);
    if(list.length == 0 ) {
      print("No item to fetch. Exiting");
      return moodlogs;
    }
    for (int i = 0; i < list.length; i++) {
      print(list[i]["mood"]);
      print(list[i]["moodStatus"]);
    }
    //print(list.length);
    return moodlogs;
  }

  deleteDB() async {
    // Delete the database
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    await deleteDatabase(path);
    print("Deleting db");
  }

  /* Future<int> deleteUsers(MoodLog user) async {
    var dbClient = await db;

    int res =
        await dbClient.rawDelete('DELETE FROM  WHERE id = ?', [user.id]);
    return res;
  }

  Future<bool> update(MoodLog user) async {
    var dbClient = await db;
    int res =   await dbClient.update("User", user.toMap(),
        where: "id = ?", whereArgs: <int>[user.id]);
    return res > 0 ? true : false;
  } */
}