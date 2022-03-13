import 'dart:async';
import '../../domain/model/todo.dart';
import '../../domain/use_case/use_cases.dart';
import 'add_edit_todo_event.dart';
import 'add_edit_todo_ui_event.dart';

class AddEditTodoViewModel {
  final UseCases useCases;

  final _eventController = StreamController<AddEditTodoUIEvent>.broadcast();

  Stream<AddEditTodoUIEvent> get eventStream => _eventController.stream;

  AddEditTodoViewModel(this.useCases);

  void onEvent(AddEditTodoEvent event) {
    event.when(saveTodo: _saveTodo);
  }

  Future<void> _saveTodo(int? id, String content, bool isCheck) async {
    if (content.isEmpty) {
      _eventController
          .add(const AddEditTodoUIEvent.showSnackBar('내용이 비어있습니다.'));
      return;
    }

    final todo = Todo(
      id: id,
      content: content,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      isCheck: isCheck,
    );

    if (id == null) {
      await useCases.addTodo(todo);
    } else {
      await useCases.updateTodo(todo);
    }

    _eventController.add(const AddEditTodoUIEvent.saveTodo());
  }
}
