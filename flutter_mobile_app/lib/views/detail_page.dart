/*
* Todo 詳細の閲覧 / 編集 / 削除
*/

import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/repository/todo_repository.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    TodoRepository todoRepo = TodoRepository();

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
      body: FutureBuilder(
          future: todoRepo.show(id),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Text('エラーが発生しました');
            }
            if (snapshot.hasData) {
              return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data?.title ?? '',
                          style: const TextStyle(fontSize: 24)),
                      const SizedBox(
                        height: 12,
                      ),
                      // ignore: todo
                      // TODO: 日付整形は共通化したい
                      Row(children: [
                        const Icon(Icons.calendar_month_outlined),
                        Text(
                            DateFormat('yyyy/MM/dd(E) HH:mm').format(
                                snapshot.data?.createdAt != null
                                    ? snapshot.data!.createdAt.toDate()
                                    : DateTime.now()),
                            style: const TextStyle(fontSize: 16)),
                      ]),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(children: const [
                        Icon(Icons.details_outlined),
                        Text('detail comming soon',
                            style: TextStyle(fontSize: 16)),
                      ])
                    ],
                  ));
            }
            return const Center(
              child: Text('読み込みに失敗しました'),
            );
          }),
    );
  }
}
