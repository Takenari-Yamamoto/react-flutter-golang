/*
* Todo の閲覧 / チェック / 追加 / 削除
*/

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../provider/todo_list_provider.dart';
import '../components/todo_input.dart';
import '../components/todo_item.dart';
import 'detail_page.dart';

class TopPage extends ConsumerWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Values
    List<Todo> todoList = ref.watch(todosProvider);
    todoList.length;
    final text = ref.watch(inputTextProvider);

    // Methods
    void moveToDetail(int i) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailPage(todoList[i]),
      ));
    }

    handleInput(String e) {
      ref.read(inputTextProvider.notifier).state = e;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo App", style: TextStyle(color: Colors.black)),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, i) {
            return TodoItem(
              id: todoList[i].id,
              title: todoList[i].title,
              isChecked: todoList[i].isChecked,
              isFavorite: todoList[i].isFavorite,
              onCheck: () => {},
              onClickText: () => {moveToDetail(i)},
              onChangeFavorite: () => [],
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
                        handleInput(e);
                      },
                      handleAdd: () => {},
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
