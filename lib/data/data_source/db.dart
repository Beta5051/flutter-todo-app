import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDB({
  required String name,
  required List<String> executes,
}) async {
  return await openDatabase(join(await getDatabasesPath(), '$name.db'),
      version: 1, onCreate: (db, _) async {
    for (final execute in executes) {
      await db.execute(execute);
    }
  });
}
