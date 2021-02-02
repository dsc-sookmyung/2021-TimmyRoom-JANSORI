import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timmyroom_jansori/models/todo_info.dart';
import 'data.dart';

final String tableName = 'toDos';

class DBHelper {
  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'toDosDB.db');

    return await openDatabase(
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
        onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  // insert // todo_info.dart
  insertToDo(ToDoInfo toDos) async {
    final db = await database;
    var res = await db.insert(tableName, toDos.toMap());
    return res;
  }

  // read
  getToDos(int id) async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $tableName WHERE id = ?', [id]);
    return res.isNotEmpty ? ToDoInfo(id: res.first['id'], name: res.first['name'], duringTime: res.first['duringTime'], restTime: res.first['restTime']) : Null;
  }

  // read all
  Future<List<ToDoInfo>> getAllToDos() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $tableName');
    List<ToDoInfo> list = res.isNotEmpty ? res.map((c) => ToDoInfo(id:c['id'], name:c['name'], duringTime: c['duringTime'], restTime: c['restTime'])).toList() : [];

    return list;
  }

  // delete
  deleteToDos(int id) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
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

