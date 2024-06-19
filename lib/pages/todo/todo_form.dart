import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rpg/models/to_do.dart';
import 'package:flutter_rpg/services/todo_store.dart';

class TodoForm extends ConsumerStatefulWidget {
  const TodoForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoFormState();
}

class _TodoFormState extends ConsumerState<TodoForm> {

    final _formGlobalKey = GlobalKey<FormState>();

  Priority _selectedPriority = Priority.low;
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return             // form stuff below here
            Form(
              key: _formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  // todo title
                  TextFormField(
                    maxLength: 20,
                    decoration: const InputDecoration(
                      label: Text('Todo title')
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'You must enter a value for the title.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    }
                  ),

                  // todo description
                  TextFormField(
                    maxLength: 40,
                    decoration: const InputDecoration(
                      label: Text('Todo description')
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty || v.length < 5) {
                        return 'Enter a description at least 5 chars long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    }
                  ),

                  // priority
                  DropdownButtonFormField(
                    value: _selectedPriority,
                    decoration: const InputDecoration(
                      label: Text('Priority of todo')
                    ),
                    items: Priority.values.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text(p.title)
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPriority = value!;
                      });
                    },
                  ),

                  // submit button
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      if (_formGlobalKey.currentState!.validate()) {
                        _formGlobalKey.currentState!.save();

                        // add new todo
                        ref.read(todoStoreProvider.notifier).addTodo(
                          Todo(
                            title: _title,
                            description: _description,
                            priority: _selectedPriority
                          ));

                        _formGlobalKey.currentState!.reset();
                        _selectedPriority = Priority.low;
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Add'),
                  )
                ],
              ), 
            );
  }
}