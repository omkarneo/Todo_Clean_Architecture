import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/repo/todoab.dart';
import '../model/task.dart';

class TodoIm implements Todoab {
  @override
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, "mytodo.db"),
        onCreate: (database, version) async {
      await database.execute("""
            CREATE TABLE TODO(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                task TEXT NOT NULL,
                time TEXT NOT NULL,
                location TEXT NOT NULL
            )
            """);
    }, version: 1);
  }

  @override
  Future<bool> insertData(insertdata) async {
    final Database db = await initDB();
    Task data = Task(
        task: insertdata['Task'],
        location: insertdata['location'],
        time: insertdata['Time']);
    db.insert("TODO", data.toJson());
    return true;
  }

  @override
  Future<List<Task>> getData() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> data = await db.query("TODO");

    // if (data.isEmpty) {
    //   return null;
    // }
    return List.generate(data.length, (index) => Task.fromJson(data[index]));
  }

  @override
  Future<void> deleteData(task) async {
    final Database db = await initDB();
    await db.delete("TODO", where: 'id=?', whereArgs: [task.id]);
  }

  @override
  Future<void> updateData(task) async {
    final Database db = await initDB();
    await db
        .update("TODO", task.toJson(), where: "id = ?", whereArgs: [task.id]);
  }
}
