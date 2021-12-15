import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final String dbpath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      dbpath,
      onCreate: (db,version)async{
        await db.execute('CREATE TABLE tasks(id INTEGER AUTOINCREMENT PRIMARY KEY,task_name TEXT,)')
      },
      version: 1,
    );
  }
}
