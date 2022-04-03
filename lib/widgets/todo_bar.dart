import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_provider/providers/all_providers.dart';

class TodoBarWidget extends ConsumerWidget {
  const TodoBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoCount = ref.watch(unCompletedProvider);
    var todoAcsion = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            todoCount == 0
                ? todoCount.toString() + ' Görev Tamam'
                : todoCount.toString() + ' Görev Yapılamadı !',
            overflow: TextOverflow.ellipsis),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoEnumListFilter.all;
            },
            child: const Text('All'),
          ),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos ',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state =
                  TodoEnumListFilter.active;
            },
            child: const Text('Active'),
          ),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state =
                  TodoEnumListFilter.completed;
            },
            child: const Text('Complet'),
          ),
        )
      ],
    );
  }
}
