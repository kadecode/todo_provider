import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoKaynak extends ConsumerWidget {
  const TodoKaynak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(child:  Text('Fulutur Provider Example')),
    );
  }
}