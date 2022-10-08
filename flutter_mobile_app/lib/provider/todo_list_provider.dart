import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Todo {
  const Todo(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.isChecked,
      required this.isFavorite});

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

  // Todo の追加
  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  // Todo の削除
  void removeTodo(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
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

// 最後に TodosNotifier のインスタンスを値に持つ StateNotifierProvider を作成し、
// UI 側から Todo リストを操作することを可能にします。
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
  return TodosNotifier();
});
