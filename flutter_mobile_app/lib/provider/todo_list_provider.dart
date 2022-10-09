import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/repository/todo_repository.dart';
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
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class TodosNotifier extends StateNotifier<List<Todo>> {
  TodosNotifier() : super([]);
  TodoRepository todoRepo = TodoRepository();

  List<TodoRepo> todoList = [];

  //初回に全件取得
  Future<void> fetchAllTodos() async {
    final res = await todoRepo.index();
    todoList = res;
  }

  // Todo の追加
  Future<void> addTodo(String title) async {
    try {
      await todoRepo.create(title);
      await todoRepo.index();
    } catch (e) {
      print(e);
    }
  }

  // Todo の完了ステータスの変更
  void check(String todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId)
          todo.copyWith(isChecked: !todo.isChecked)
        else
          todo,
    ];
  }

  // お気に入り登録
  void registerFavorite(String todoId) {
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
final todoListProvider = FutureProvider((ref) async {
  TodoRepository todoRepo = TodoRepository();
  final res = await todoRepo.index();
  return res;
});
