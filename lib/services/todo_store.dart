import 'package:flutter_rpg/models/to_do.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_store.g.dart';

@riverpod
class TodoStore extends _$TodoStore {
  @override
  List<Todo> build() {
    return [
    Todo(
      title: 'Buy milk', 
      description: 'There is no milk left in the fridge!',
      priority: Priority.high
    ),
    Todo(
      title: 'Make the bed', 
      description: 'Keep things tidy please..',
      priority: Priority.low
    ),
    Todo(
      title: 'Pay bills', 
      description: 'The gas bill needs paying ASAP.',
      priority: Priority.urgent
    ),
  ];;
  }

  void addTodo(Todo todo) {
    if (!state.contains(todo)) {
      state = [...state, todo];
    }
  }
}