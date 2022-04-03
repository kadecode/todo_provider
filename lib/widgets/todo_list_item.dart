// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_provider/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textNode;
  late TextEditingController _controlText;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textNode = FocusNode();
    _controlText = TextEditingController();
  }

  @override
  void dispose() {
    _textNode.dispose();
    _controlText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curretItem = ref.watch(currentTodo);
    return Focus(
      onFocusChange: (value) =>
          {!value ? setState(() => hasFocus = false) : null},
      child: ListTile(
        onTap: () {
          setState(() {
            hasFocus = true;
            ref
                .read(todoListProvider.notifier)
                .edit(curretItem.id, _controlText.text);
          });
          _textNode.requestFocus();
          _controlText.text = curretItem.desctiption;
        },
        leading: Checkbox(
          value: curretItem.completed,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggle(curretItem.id);
          },
        ),
        title: hasFocus
            ? TextField(
                controller: _controlText,
                focusNode: _textNode,
              )
            : Text(curretItem.desctiption),
      ),
    );
  }
}
