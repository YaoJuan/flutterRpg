import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rpg/models/to_do.dart';
import 'package:flutter_rpg/pages/todo/todo_form.dart';
import 'package:flutter_rpg/pages/todo/todo_list.dart';
import 'package:flutter_rpg/services/todo_store.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {


  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoStoreProvider);
   return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: TodoList(todos: todos)),
        
            // form stuff below here
            const TodoForm()
            
          ],
        ),
      ),
    );
  }
}