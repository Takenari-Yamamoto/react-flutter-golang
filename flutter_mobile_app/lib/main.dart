import 'package:flutter/material.dart';

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
  final List<Map<String, dynamic>> todoList = [
    {'title': 'tennidds', 'isChecked': false},
    {'title': 'ラーメン', 'isChecked': false},
    {'title': '餃子つくる', 'isChecked': false},
    {'title': 'Flutter極める', 'isChecked': false},
    {'title': 'お酒のむ', 'isChecked': false},
  ];

  String _text = "";
  void _handleInput(String e) {
    print('入力された-->>>');
    print(e);
    setState(() {
      _text = e;
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
          itemCount: todoList.length,
          itemBuilder: (context, i) {
            return CheckboxListTile(
                title: Text(todoList[i]['title']),
                value: todoList[i]['isChecked'],
                onChanged: (value) {
                  setState(() {
                    todoList[i]['isChecked'] = !todoList[i]['isChecked'];
                  });
                });
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
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(children: [
                      Flexible(
                          child: TextField(
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        onChanged: (String text) {
                          print(text);
                          _handleInput;
                        },
                      )),
                      TextButton(
                          onPressed: () {
                            print('追加');
                          },
                          child: const Text('追加'))
                    ]),
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
