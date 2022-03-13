import '../../domain/model/todo.dart';
import '../../domain/repository/todo_repository.dart';
import '../data_source/todo_db_helper.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDBHelper dbHelper;

  TodoRepositoryImpl(this.dbHelper);

  @override
  Future<List<Todo>> getTodos() async => await dbHelper.getAllTodos();

  @override
  Future<void> addTodo(Todo todo) async => await dbHelper.insertTodo(todo);

  @override
  Future<void> updateTodo(Todo todo) async => await dbHelper.updateTodo(todo);

  @override
  Future<void> removeTodo(Todo todo) async {
    if (todo.id != null) {
      await dbHelper.deleteTodoById(todo.id!);
    }
  }
}
