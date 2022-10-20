import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiMethod {
  Future<Response> index() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/todos/");
    final res = await http.get(url);
    return res;
  }
}
