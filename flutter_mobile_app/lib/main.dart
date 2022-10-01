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
  static const todoList = ['tennis', 'ラーメン食べる', 'Flutter 極める'];
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(widget.title, style: const TextStyle(color: Colors.black)),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        body: Column(children: [
          for (var i = 0; i < 20; i++)
            CheckboxListTile(
              title: const Text('Animate Slowly'),
              value: _isChecked,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
        ]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  Spacer(),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                ],
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => print("クリックされました"),
          tooltip: 'Create',
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: Colors.blueAccent,
          ),
        ));
  }
}
