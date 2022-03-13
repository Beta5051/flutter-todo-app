import 'add_todo_use_case.dart';
import 'get_todos_use_case.dart';
import 'remove_todo_use_case.dart';
import 'update_todo_use_case.dart';

class UseCases {
  final GetTodosUseCase getTodos;
  final AddTodoUseCase addTodo;
  final UpdateTodoUseCase updateTodo;
  final RemoveTodoUseCase removeTodo;

  UseCases({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.removeTodo,
  });
}
