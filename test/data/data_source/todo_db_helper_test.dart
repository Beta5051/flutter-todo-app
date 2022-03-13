import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo/data/data_source/todo_db_helper.dart';
import 'package:todo/domain/model/todo.dart';

void main() {
  test('TodoDBHelper test', () async {
    final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    await db.execute(
        'CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, timestamp INTEGER, isCheck INTEGER)');

    final todoDBHelper = TodoDBHelper(db);

    final todo = Todo(
      content: 'test',
      timestamp: 0,
    );

    await todoDBHelper.insertTodo(todo);

    expect((await todoDBHelper.getTodoById(1))?.content, 'test');

    expect((await todoDBHelper.getAllTodos()).length, 1);

    await todoDBHelper.updateTodo(todo.copyWith(id: 1, content: 'test 2'));

    expect((await todoDBHelper.getAllTodos()).first.content, 'test 2');

    await todoDBHelper.deleteTodoById(1);

    expect((await todoDBHelper.getAllTodos()).length, 0);

    await todoDBHelper.insertTodo(todo);

    await todoDBHelper.deleteAllTodos();

    expect((await todoDBHelper.getAllTodos()).length, 0);

    await db.close();
  });
}
