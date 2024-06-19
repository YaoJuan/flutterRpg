import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'to_do.freezed.dart';
part 'to_do.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo(
      {required String title,
      required String description,
      required Priority priority}) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}




enum Priority {
  urgent(color: Colors.red, title: 'Urgent'),
  high(color: Colors.orange, title: 'High'),
  medium(color: Colors.amber, title: 'Medium'),
  low(color: Colors.green, title: 'Low');

  const Priority({required this.color, required this.title});

  final Color color;
  final String title;
}



