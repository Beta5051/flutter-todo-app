import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/model/todo.dart';
import '../../domain/use_case/use_cases.dart';
import '../../domain/utils/sort_type.dart';
import 'todos_event.dart';
import 'todos_state.dart';

class TodosViewModel with ChangeNotifier {
  final UseCases useCases;

  TodosState _state = TodosState(
    todos: [],
    removeTodos: [],
    sortType: SortType.ascending,
  );

  TodosState get state => _state;

  TodosViewModel(this.useCases) {
    _loadTodos();
  }

  void onEvent(TodosEvent event) {
    event.when(
      loadTodos: _loadTodos,
      checkToggle: _checkToggle,
      removeTodo: _removeTodo,
      restoreTodo: _restoreTodo,
      toggleSort: _toggleSort,
    );
  }

  Future<void> _loadTodos() async {
    final todos = await useCases.getTodos(state.sortType);
    _state = state.copyWith(todos: todos);
    notifyListeners();
  }

  Future<void> _checkToggle(Todo todo) async {
    await useCases
        .updateTodo(todo.copyWith(isCheck: !todo.isCheck));
    await _loadTodos();
  }

  Future<void> _removeTodo(Todo todo) async {
    await useCases.removeTodo(todo);
    _state = state.copyWith(removeTodos: [
      todo,
      ...state.removeTodos,
    ]);
    await _loadTodos();
  }

  Future<void> _restoreTodo() async {
    if (state.removeTodos.isNotEmpty) {
      await useCases.addTodo(state.removeTodos.first);
      _state = state.copyWith(removeTodos: state.removeTodos.sublist(1));
      await _loadTodos();
    }
  }

  Future<void> _toggleSort() async {
    _state = state.copyWith(
        sortType: state.sortType == SortType.ascending
            ? SortType.descending
            : SortType.ascending);
    await _loadTodos();
  }
}
