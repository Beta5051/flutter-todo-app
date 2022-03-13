import '../model/todo.dart';
import '../repository/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase(this.repository);

  Future<void> call(Todo todo) async => await repository.addTodo(todo);
}
