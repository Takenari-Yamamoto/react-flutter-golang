import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/todo_model.dart';
import 'package:flutter_mobile_app/service/api_service.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Mobile App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [];
  final client = ApiService();

  Future<void> getData() async {
    var response = await http
        .get(Uri.https('https://jsonplaceholder.typicode.com', '/todos'));

    print(response.body);

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);

    setState(() {
      items = jsonResponse;
    });
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<TodoEntity?>>(
          future: client.fetchAllTodos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('エラーやけん');
            }
            if (snapshot.hasData) {
              final todoList = snapshot.data;
              return ListView.builder(
                  itemCount: todoList?.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text('ID$i : ${todoList?[i]?.title}'),
                    );
                  });
            }
            return const Text('読み込み中');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
