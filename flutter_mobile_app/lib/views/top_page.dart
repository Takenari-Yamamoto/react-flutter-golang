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
      setState(() {});
    }

    handleCheck(String id) {
      todoMethod.check(id);
    }

    handleFavorite(String id) {
      todoMethod.registerFavorite(id);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo App", style: TextStyle(color: Colors.black)),
          centerTitle: false,
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: todoMethod.fetchAllTodos(),
          builder: (ctx, data) {
            if (data.hasError) {
              return const Text('エラーが発生しました');
            }
            if (data.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (data.hasData) {
              return ListView.builder(
                itemCount: data.data?.length,
                itemBuilder: (context, i) {
                  return TodoItem(
                    id: data.data?[i].id ?? '',
                    title: data.data?[i].title ?? '',
                    isChecked: data.data?[i].isChecked ?? false,
                    isFavorite: data.data?[i].isFavorite ?? false,
                    onCheck: () => {handleCheck(data.data?[i].id ?? '')},
                    onClickText: () => {moveToDetail(data.data?[i].id ?? '')},
                    onChangeFavorite: () =>
                        [handleFavorite(data.data?[i].id ?? '')],
                  );
                },
              );
            }
            return const Text('APIからデータの取得に失敗しました。再度試してください');
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
