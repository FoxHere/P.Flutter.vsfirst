import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:vsfirst/data/task_dao.dart';

Future<Database> getDatabase() async {
  String path = p.join(await getDatabasesPath(), 'task.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TaskDao.tableSql);
    },
    version: 1,
  );
}
