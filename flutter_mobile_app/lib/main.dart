import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/components/parts/todo_input.dart';
import 'package:flutter_mobile_app/components/parts/todo_item.dart';
import 'package:flutter_mobile_app/components/pages/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Todo Lists',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sample Todo Lists'),
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
  String _text = "";
  final List<Map<String, dynamic>> _todoList = [];

  void _handleInput(String e) {
    setState(() {
      _text = e;
    });
  }

  void _addTodo(String e) {
    setState(() {
      _todoList.add({
        'id': 'id4524werwe',
        'title': e,
        'createdAt': DateTime.now(),
        'isChecked': false,
        'isFavorite': false
      });
    });
  }

  void _handleCheck(int i) {
    setState(() {
      _todoList[i]['isChecked'] = !_todoList[i]['isChecked'];
    });
  }

  void _moveToDetail(int i) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DetailPage(_todoList[i]),
    ));
  }

  void _clickFavorite(int i) {
    setState(() {
      _todoList[i]['isFavorite'] = !_todoList[i]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.title, style: const TextStyle(color: Colors.black)),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, i) {
            return TodoItem(
              id: _todoList[i]['id'],
              title: _todoList[i]['title'],
              isChecked: _todoList[i]['isChecked'],
              isFavorite: _todoList[i]['isFavorite'],
              onCheck: () => _handleCheck(i),
              onClickText: () => _moveToDetail(i),
              onChangeFavorite: () => _clickFavorite(i),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  const Spacer(),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                ],
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: TodoInput(
                      handleInput: (e) {
                        _handleInput(e);
                      },
                      handleAdd: () => _addTodo(_text),
                    ),
                  );
                })
          },
          tooltip: 'Create',
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.blueAccent,
          ),
        ));
  }
}
