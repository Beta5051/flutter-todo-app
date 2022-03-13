import '../model/todo.dart';
import '../repository/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase(this.repository);

  Future<void> call(Todo todo) async => await repository.updateTodo(todo);
}
