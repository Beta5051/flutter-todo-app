import '../model/todo.dart';
import '../repository/todo_repository.dart';
import '../utils/sort_type.dart';

class GetTodosUseCase {
  final TodoRepository repository;

  GetTodosUseCase(this.repository);

  Future<List<Todo>> call(SortType sortType) async {
    final todos = await repository.getTodos();
    todos.sort((a, b) =>
        ((sortType == SortType.ascending) ? 1 : -1) *
        a.timestamp.compareTo(b.timestamp));
    return todos;
  }
}
