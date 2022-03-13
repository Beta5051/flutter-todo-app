import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/utils/sort_type.dart';
import '../add_edit_todo/add_edit_todo_screen.dart';
import 'components/todo_item.dart';
import 'todos_event.dart';
import 'todos_view_model.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodosViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          viewModel.state.removeTodos.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.restore),
                  onPressed: () =>
                      viewModel.onEvent(const TodosEvent.restoreTodo()),
                )
              : Container(),
          IconButton(
            icon: Icon(viewModel.state.sortType == SortType.ascending
                ? CupertinoIcons.sort_up
                : CupertinoIcons.sort_down),
            onPressed: () => viewModel.onEvent(const TodosEvent.toggleSort()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            final bool? isSaved = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddEditTodoScreen()));
            if (isSaved == true) {
              viewModel.onEvent(const TodosEvent.loadTodos());
            }
          }),
      body: ListView(
        children: viewModel.state.todos
            .map((e) => TodoItem(
                  todo: e,
                  onCheckBoxTap: () =>
                      viewModel.onEvent(TodosEvent.checkToggle(e)),
                ))
            .toList(),
      ),
    );
  }
}
