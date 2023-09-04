import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task.dart';

class DB {
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

  Future<bool> insertData(Task task) async {
    final Database db = await initDB();
    db.insert("TODO", task.toJson());
    return true;
  }

  Future<List<Task>?> getData() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> data = await db.query("TODO");

    if (data.isEmpty) {
      return null;
    }
    return List.generate(data.length, (index) => Task.fromJson(data[index]));
  }

  Future<void> deleteData(Task task) async {
    final Database db = await initDB();
    await db.delete("TODO", where: 'id=?', whereArgs: [task.id]);
  }

  Future<void> updateData(Task task) async {
    final Database db = await initDB();
    await db
        .update("TODO", task.toJson(), where: "id = ?", whereArgs: [task.id]);
  }
}
