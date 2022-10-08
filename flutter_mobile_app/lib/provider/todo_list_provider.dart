import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Todo {
  const Todo(
      {required this.id,
      required this.title,
      required this.createdAt,
      this.isChecked = false,
      this.isFavorite = false});

  final String id;
  final String title;
  final DateTime createdAt;
  final bool isChecked;
  final bool isFavorite;

  Todo copyWith(
      {String? id,
      String? title,
      DateTime? createdAt,
      bool? isChecked,
      bool? isFavorite}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      isChecked: isChecked ?? this.isChecked,
      isFavorite: isFavorite ?? this.isChecked,
    );
  }
}

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);

  // title の入力
  void handleInput(String e) {}

  // Todo の追加
  void addTodo(String uuid, String title) {
    state = [...state, Todo(id: uuid, title: title, createdAt: DateTime.now())];
  }

  // Todo の完了ステータスの変更
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(isChecked: !todo.isChecked)
        else
          todo,
    ];
  }
}

// Provider の提供
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});
final inputTextProvider = StateProvider<String>((ref) => '');
