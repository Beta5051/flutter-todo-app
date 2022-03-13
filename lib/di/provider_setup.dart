import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../data/data_source/db.dart';
import '../data/data_source/todo_db_helper.dart';
import '../data/repository/todo_repository_impl.dart';
import '../domain/use_case/add_todo_use_case.dart';
import '../domain/use_case/get_todos_use_case.dart';
import '../domain/use_case/remove_todo_use_case.dart';
import '../domain/use_case/update_todo_use_case.dart';
import '../domain/use_case/use_cases.dart';
import '../presentation/add_edit_todo/add_edit_todo_view_model.dart';
import '../presentation/todos/todos_view_model.dart';

Future<List<SingleChildWidget>> getProviders() async {
  final db = await initDB(
    name: 'todo',
    executes: [
      'CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, timestamp INTEGER, isCheck INTEGER)',
    ],
  );

  final todoDBHelper = TodoDBHelper(db);
  final todoRepository = TodoRepositoryImpl(todoDBHelper);
  final useCases = UseCases(
    getTodos: GetTodosUseCase(todoRepository),
    addTodo: AddTodoUseCase(todoRepository),
    updateTodo: UpdateTodoUseCase(todoRepository),
    removeTodo: RemoveTodoUseCase(todoRepository),
  );

  return [
    ChangeNotifierProvider(create: (_) => TodosViewModel(useCases)),
    Provider(create: (_) => AddEditTodoViewModel(useCases)),
  ];
}
