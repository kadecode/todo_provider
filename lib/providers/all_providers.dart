import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_provider/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_models.dart';

enum TodoEnumListFilter { all, active, completed }
final todoListFilter =
    StateProvider<TodoEnumListFilter>((ref) => TodoEnumListFilter.all);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModels>>((ref) {
  return TodoListManager([
    TodoModels(id: const Uuid().v4(), desctiption: 'Spor yap'),
    TodoModels(id: const Uuid().v4(), desctiption: 'Ders çalışma'),
    TodoModels(id: const Uuid().v4(), desctiption: 'Kitap okuma ')
  ]);
});
final unCompletedProvider = Provider((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
});
final currentTodo = Provider<TodoModels>((ref) {
  throw UnimplementedError();
});
final filteredTodoList = Provider<List<TodoModels>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);
  switch (filter) {
    case TodoEnumListFilter.all:
      return todoList;
    case TodoEnumListFilter.completed:
      return todoList.where((element) => element.completed).toList();
    case TodoEnumListFilter.active:
      return todoList.where((element) => !element.completed).toList();
  }
});
