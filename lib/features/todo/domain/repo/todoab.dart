import 'package:sqflite/sqflite.dart';
import '../enitites/task.dart';

abstract class Todoab {
  Future initDB();
  Future getData();
  Future insertData(params);
  Future deleteData(params);
  Future updateData(params);
}
