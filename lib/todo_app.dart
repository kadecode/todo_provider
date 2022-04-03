import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_provider/providers/all_providers.dart';
import 'package:todo_provider/widgets/todo.text.dart';
import 'package:todo_provider/widgets/todo_bar.dart';
import 'package:todo_provider/widgets/todo_kaynak.dart';
import 'package:todo_provider/widgets/todo_list_item.dart';

// ignore: must_be_immutable
class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleTodoText(),
          TextField(
            controller: newTodoController,
            decoration: const InputDecoration(
                labelText: 'Bu Gün Neler Yapamayı Planlanıyorsun !'),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
              debugPrint('Eklenen $newTodo');
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const TodoBarWidget(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).remode(allTodos[i]);
              },
              child: ProviderScope(
                overrides: [
                  currentTodo.overrideWithValue(allTodos[i]),
                ],
                child: const TodoListItemWidget(),
              ),
            ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>const TodoKaynak()));
              },
              child: const Text('Todo Kaynakları'))
        ],
      ),
    );
  }
}
