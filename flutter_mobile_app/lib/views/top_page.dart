/*
* Todo の閲覧 / チェック / 追加 / 削除
*/

import 'package:cloud_firestore/cloud_firestore.dart';
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
    String text = ref.read(inputTextProvider.notifier).state;
    var todoMethod = ref.read(todosProvider.notifier);

    // Methods
    // FIX: 以下の処理も provider に書けるやん
    moveToDetail(String id) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailPage(id),
      ));
    }

    handleInput(String e) {
      text = e;
    }

    addItem() async {
      await todoMethod.addTodo(text);
    }

    handleCheck(String id) {
      todoMethod.check(id);
    }

    handleFavorite(String id) {
      todoMethod.registerFavorite(id);
    }

    fetchByStream() {
      var res = FirebaseFirestore.instance
          .collection('todo')
          .orderBy("createdAt", descending: true)
          .snapshots();
      return res;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo App", style: TextStyle(color: Colors.black)),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder(
          stream: fetchByStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return TodoItem(
                      id: data['id'] ?? '-',
                      title: data['title'] ?? '-',
                      isChecked: data['isChecked'] ?? false,
                      isFavorite: data['isFavorite'] ?? false,
                      onCheck: () => {handleCheck(data['id'] ?? '')},
                      onClickText: () => {moveToDetail(data['id'] ?? '')},
                      onChangeFavorite: () =>
                          [handleFavorite(data['id'] ?? '')],
                    );
                  })
                  .toList()
                  .cast(),
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
                      handleAdd: () => {addItem()},
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
