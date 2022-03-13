import '../model/todo.dart';
import '../repository/todo_repository.dart';

class RemoveTodoUseCase {
  final TodoRepository repository;

  RemoveTodoUseCase(this.repository);

  Future<void> call(Todo todo) async => await repository.removeTodo(todo);
}
