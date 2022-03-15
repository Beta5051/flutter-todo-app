import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/data_source/db.dart';
import 'di/provider_setup.dart';
import 'presentation/todos/todos_screen.dart';
import 'ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await initDB(
    name: 'todo',
    executes: [
      'CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, timestamp INTEGER, isCheck INTEGER)',
    ],
  );

  runApp(MultiProvider(
    providers: getProviders(db),
    child: const TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const TodosScreen(),
    );
  }
}

