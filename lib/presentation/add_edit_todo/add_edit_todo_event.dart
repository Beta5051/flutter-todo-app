import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_todo_event.freezed.dart';

@freezed
class AddEditTodoEvent with _$AddEditTodoEvent {
  const factory AddEditTodoEvent.saveTodo(
      int? id, String content, bool isCheck) = _SaveTodo;
}
