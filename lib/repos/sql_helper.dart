import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/todo_model.dart';

class SqlHelper {
  static late Database database;
  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createTableTodo(db);
    });
  }

  static createTableTodo(db) async {
    await db.execute('''
CREATE TABLE $TodoTable 
($ColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
 $ColumnTitle TEXT,
  $ColumnDateTime TEXT,
   $ColumnBody TEXT,
    $ColumnStatus INTEGER)
          ''');
  }

  static Future insertTodo(TodoModel item) async {
    await database.rawInsert('''
INSERT INTO $TodoTable
($ColumnTitle, $ColumnDateTime, $ColumnBody , $ColumnStatus)
 VALUES("${item.title}", "${item.dateTime}", "${item.body}" ,"${item.status! ? 1 : 0}" )
        ''');
  }

  static Future<List<TodoModel>> getAllTodos() async {
    List<TodoModel> list = [];
    List<Map> maps = await database.rawQuery('SELECT * FROM $TodoTable');

    for (var element in maps) {
      list.add(TodoModel.fromDatabase(element));
    }

    return list;
  }

  static Future editTodo(TodoModel item) async {
    await database.rawUpdate(
        'UPDATE $TodoTable SET $ColumnTitle = ?, $ColumnDateTime = ? , $ColumnBody = ? ,$ColumnStatus = ?   WHERE $ColumnId = ?',
        [
          '${item.title}',
          '${item.dateTime}',
          '${item.body}',
          '${item.status! ? 1 : 0}',
          item.id
        ]);
  }

  static deleteTodo(int id) {
    database.rawDelete('DELETE FROM $TodoTable WHERE $ColumnId = ?', [id]);
  }
}
