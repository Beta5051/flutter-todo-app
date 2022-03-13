import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../domain/model/todo.dart';
import '../../add_edit_todo/add_edit_todo_screen.dart';
import '../todos_event.dart';
import '../todos_view_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function() onCheckBoxTap;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onCheckBoxTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TodosViewModel>();

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => viewModel.onEvent(TodosEvent.removeTodo(todo)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
        child: GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('yyyy/MM/dd HH:mm').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                todo.timestamp)),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(todo.isCheck
                      ? Icons.check_box
                      : Icons.check_box_outline_blank),
                  onPressed: onCheckBoxTap,
                ),
              ],
            ),
          ),
          onTap: () async {
            final bool? isSaved = await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => AddEditTodoScreen(todo: todo)));
            if (isSaved == true) {
              viewModel.onEvent(const TodosEvent.loadTodos());
            }
          },
        ),
      ),
    );
  }
}
