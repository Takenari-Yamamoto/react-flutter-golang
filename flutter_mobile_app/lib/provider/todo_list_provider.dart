import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/repository/todo_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

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
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);
  TodoRepository todoRepo = TodoRepository();

  // List<TodoRepo> todoList = [];

  //初回に全件取得
  Future<List<TodoRepo>?> fetchAllTodos() async {
    try {
      final res = await todoRepo.index();
      ;
      return res;
    } catch (e) {
      print(e);
    }
  }

  // Todo の追加
  Future<void> addTodo(String title) async {
    var uuid = const Uuid().v4();
    try {
      await todoRepo.create(title, uuid);
    } catch (e) {
      print(e);
    }
  }

  // Todo の完了ステータスの変更
  check(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(isChecked: !todo.isChecked)
        else
          todo,
    ];
  }

  // お気に入り登録
  registerFavorite(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(isFavorite: !todo.isFavorite)
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
