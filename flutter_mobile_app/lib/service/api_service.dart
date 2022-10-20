import 'dart:convert';
import 'package:flutter_mobile_app/model/todo_model.dart';

import '../repository/api_repository.dart';

class ParserService {
  // TodoEntity の部分は generics 使えそう
  List<TodoEntity> parseTodos(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<TodoEntity>((json) => TodoEntity.fromJson(json)).toList();
  }
}

class ApiService {
  final client = ApiMethod();
  final parser = ParserService();

  Future<List<TodoEntity?>> fetchAllTodos() async {
    final res = await client.index();
    final list = parser.parseTodos(res.body);
    return list;
  }
}
