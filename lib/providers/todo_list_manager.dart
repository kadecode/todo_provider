import 'package:todo_provider/models/todo_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModels>> {
  TodoListManager([List<TodoModels>? stateTodo]) : super(stateTodo ?? []);

  void addTodo(String desctiption) {
    var gelenDeger =
        TodoModels(id: const Uuid().v4(), desctiption: desctiption);
    state = [...state, gelenDeger];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        todo.id == id
            ? TodoModels(
                id: todo.id,
                desctiption: todo.desctiption,
                completed: !todo.completed)
            : todo,
    ];
  }

  void edit(String id, String newDesctiption) {
    state = [
      for (var todo in state)
        todo.id == id
            ? TodoModels(
                id: todo.id,
                completed: todo.completed,
                desctiption: newDesctiption)
            : todo,
    ];
  }

  void remode(TodoModels silTodo) {
    state = state.where((element) => element.id != silTodo.id).toList();
  }

  int unCompletedCount() {
    return state.where((element) => !element.completed).length; 
  }
}
