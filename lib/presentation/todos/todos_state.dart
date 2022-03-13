import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/model/todo.dart';
import '../../domain/utils/sort_type.dart';

part 'todos_state.freezed.dart';

@freezed
class TodosState with _$TodosState {
  factory TodosState({
    required List<Todo> todos,
    required List<Todo> removeTodos,
    required SortType sortType,
  }) = _Todos;
}