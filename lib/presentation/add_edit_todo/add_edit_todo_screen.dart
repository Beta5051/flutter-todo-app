import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/model/todo.dart';
import 'add_edit_todo_event.dart';
import 'add_edit_todo_view_model.dart';

class AddEditTodoScreen extends StatefulWidget {
  final Todo? todo;

  const AddEditTodoScreen({
    Key? key,
    this.todo,
  }) : super(key: key);

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final _contentController = TextEditingController();
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) _contentController.text = widget.todo!.content;

    Future.microtask(() {
      final viewModel = context.read<AddEditTodoViewModel>();

      _streamSubscription = viewModel.eventStream.listen((event) {
        event.when(
          saveTodo: () => Navigator.pop(context, true),
          showSnackBar: (message) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message))),
        );
      });
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddEditTodoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add Todo' : 'Edit Todo'),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(widget.todo == null ? Icons.add : Icons.save),
        onPressed: () => viewModel.onEvent(AddEditTodoEvent.saveTodo(
          widget.todo?.id,
          _contentController.text,
          widget.todo != null ? widget.todo!.isCheck : false,
        )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _contentController,
            maxLines: null,
            decoration: const InputDecoration.collapsed(hintText: '내용을 입력하세요.'),
            cursorColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
