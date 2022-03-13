import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/model/todo.dart';

part 'todos_event.freezed.dart';

@freezed
class TodosEvent with _$TodosEvent {
  const factory TodosEvent.loadTodos() = _LoadTodos;
  const factory TodosEvent.checkToggle(Todo todo) = _CheckToggle;
  const factory TodosEvent.removeTodo(Todo todo) = _RemoveTodo;
  const factory TodosEvent.restoreTodo() = _RetstoreTodo;
  const factory TodosEvent.toggleSort() = _ToggleSort;
}