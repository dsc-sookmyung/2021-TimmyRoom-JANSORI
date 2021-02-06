import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:timmyroom_jansori/models/sound_info.dart';
import 'package:timmyroom_jansori/models/todo_info.dart';

final String tableName = 'sounds';
final String colId = 'id';
final String colPath = 'path';

class SoundHelper {
  static Database _soundDatabase;
  static SoundHelper _soundHelper;


  SoundHelper._createInstance();
  factory SoundHelper(){
    if( _soundHelper == null) {
      _soundHelper = SoundHelper._createInstance();
    }
    return _soundHelper;
  }

  Future<Database> get database async {
    if (_soundDatabase == null) {
      _soundDatabase = await initDB();
    }
    return _soundDatabase;
  }

  Future<Database> initDB() async {
    var dir = await getDatabasesPath();
    var path = dir + "soundDB2.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE $tableName(
              $colId INTEGER NOT NULL PRIMARY KEY),
              $colPath TEXT
            ''');
      },
    );
    return database;
  }

  // insert // todo_info.dart
  void insertSound(SoundInfo soundInfo) async {
    final db = await database;
    var res = await db.insert(tableName, soundInfo.toMap());
    print('db 저장된 갯수: $res');
  }

  // read
  Future<List<SoundInfo>> getSounds() async {
    List<SoundInfo> _sounds = [];

    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var soundInfo = SoundInfo().fromMap(element);
      _sounds.add(soundInfo);
    });
    return _sounds;
  }

  // delete
  Future<int> deleteSound(int id) async {
    final db = await database;
    var res = db.delete(tableName, where: '$colId =?', whereArgs: [id]);
    return res;
  }

}

