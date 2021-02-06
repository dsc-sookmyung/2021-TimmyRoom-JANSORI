import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:timmyroom_jansori/models/todo_info.dart';

final String tableName = 'toDos';
final String colId = 'id';
String colName = 'name';
String colDuringTime = 'duringTime';
String colRestTime = 'restTime';
String colIsOn = 'isOn';
String colSoundIdx = 'soundIdx';

class DBHelper {
  static Database _database;
  static DBHelper _dbHelper;


  DBHelper._createInstance();
  factory DBHelper(){
    if(_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  Future<Database> initDB() async {
    var dir = await getDatabasesPath();
    var path = dir + "toDos2.db";

    var database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE $tableName(
              $colId INTEGER NOT NULL PRIMARY KEY,
              $colName TEXT,
              $colDuringTime INTEGER,
              $colRestTime INTEGER,
              $colIsOn INTEGER,
              $colSoundIdx TEXT
              )
            ''');
        },
    );
    return database;
  }

  // insert // todo_info.dart
  void insertToDo(ToDoInfo todoInfo) async {
    final db = await database;
    var res = await db.insert(tableName, todoInfo.toMap());
    print('db 저장된 갯수: $res');
  }

  updateIsOn(int id, int value) async {
    final db = await database;
    var res = await db.rawUpdate('UPDATE $tableName SET $colIsOn = ? WHERE $colId = ?', [value, id]);
  }

  // read
  Future<List<ToDoInfo>> getToDos() async {
    List<ToDoInfo> _toDos = [];

    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var todoInfo = ToDoInfo.fromMap(element);
      _toDos.add(todoInfo);
    });
    return _toDos;
  }

  // delete
  Future<int> delete(int id) async {
    final db = await database;
    var res = db.delete(tableName, where: '$colId =?', whereArgs: [id]);
    return res;
  }

  // delete all
  deleteAllToDos() async {
    final db = await database;
    db.rawDelete('DELETE FROM $tableName');
  }

  // update
  updateToDos(ToDoInfo todos) async {
    final db = await database;
    var res = db.rawUpdate('UPDATE $tableName SET name = ? WHERE id = ?', [todos.name, todos.id]);
    return res;
  }
}

