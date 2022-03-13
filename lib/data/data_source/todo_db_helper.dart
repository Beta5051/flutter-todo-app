import 'package:sqflite/sqflite.dart';
import '../../domain/model/todo.dart';

class TodoDBHelper {
  Database db;

  TodoDBHelper(this.db);

  Future<Todo?> getTodoById(int id) async {
    final data = await db.query('todo', where: 'id = ?', whereArgs: [id]);
    if (data.isEmpty) return null;
    return Todo.fromJson(data.first);
  }

  Future<List<Todo>> getAllTodos() async {
    final data = await db.query('todo');
    return data.map((e) => Todo.fromJson(e)).toList();
  }

  Future<int> insertTodo(Todo todo) async =>
      await db.insert('todo', todo.toJson());

  Future<int> updateTodo(Todo todo) async => await db
      .update('todo', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);

  Future<int> deleteTodoById(int id) async =>
      await db.delete('todo', where: 'id = ?', whereArgs: [id]);

  Future<void> deleteAllTodos() async => await db.delete('todo');
}
