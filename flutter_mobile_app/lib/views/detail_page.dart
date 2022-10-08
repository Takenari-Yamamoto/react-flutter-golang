/*
* Todo 詳細の閲覧 / 編集 / 削除
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/provider/todo_list_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todoList = ref.watch(todosProvider);
    Todo todoItem = todoList.firstWhere((todo) => todo.id == id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {Navigator.of(context).pop()},
          color: const Color.fromARGB(255, 96, 96, 96),
        ),
        title: const Text('Detail', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todoItem.title, style: const TextStyle(fontSize: 24)),
              const SizedBox(
                height: 12,
              ),
              Row(children: [
                const Icon(Icons.calendar_month_outlined),
                Text(
                    DateFormat('yyyy/MM/dd(E) HH:mm')
                        .format(todoItem.createdAt),
                    style: const TextStyle(fontSize: 16)),
              ]),
              const SizedBox(
                height: 12,
              ),
              Row(children: const [
                Icon(Icons.details_outlined),
                Text('detail comming soon', style: TextStyle(fontSize: 16)),
              ])
            ],
          )),
    );
  }
}
