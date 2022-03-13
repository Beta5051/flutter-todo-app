import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_edit_todo_ui_event.freezed.dart';

@freezed
class AddEditTodoUIEvent with _$AddEditTodoUIEvent {
  const factory AddEditTodoUIEvent.saveTodo() = _SaveTodo;
  const factory AddEditTodoUIEvent.showSnackBar(String message) = _ShowSnackBar;
}
