import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/domain/model/todo.dart';
import 'package:todo/domain/repository/todo_repository.dart';
import 'package:todo/domain/use_case/get_todos_use_case.dart';
import 'package:todo/domain/utils/sort_type.dart';
import 'use_cases_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  test('GetTodosUseCases test', () async {
    final todoRepository = MockTodoRepository();

    when(todoRepository.getTodos()).thenAnswer(
      (_) async {
        return [
          Todo(
            content: 'test',
            timestamp: 0,
          ),
          Todo(
            content: 'test 2',
            timestamp: 2,
          )
        ];
      },
    );

    final getTodosUseCase = GetTodosUseCase(todoRepository);

    final result = await getTodosUseCase(SortType.descending);
    expect(result, isA<List<Todo>>());
    expect(result.first.timestamp, 2);
    verify(todoRepository.getTodos());

    verifyNoMoreInteractions(todoRepository);
  });
}
