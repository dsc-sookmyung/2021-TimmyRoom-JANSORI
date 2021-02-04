import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:timmyroom_jansori/models/todo_info.dart';

final String tableName = 'toDos';
final String colId = 'id';
String colName = 'name';
String colDuringTime = '0';
String colRestTime = '0';

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
    var path = dir + "toDos.db";

    var database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE $tableName(
              'id' INTEGER NOT NULL PRIMARY KEY,
              'name' TEXT,
              'duringTime' INTEGER,
              'restTime' INTEGER
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
    var res = db.rawUpdate('UPDATE $tableName SET name = ? WHERE = ?', [todos.name, todos.id]);
    return res;
  }
}

