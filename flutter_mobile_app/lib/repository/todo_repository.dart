import 'package:cloud_firestore/cloud_firestore.dart';

// 参考: https://firebase.google.com/docs/firestore/query-data/get-data?hl=ja#custom_objects
class TodoRepo {
  final String? id;
  final String? title;
  final Timestamp? createdAt;
  final bool? isChecked;
  final bool? isFavorite;

  TodoRepo(
      {this.id, this.title, this.createdAt, this.isChecked, this.isFavorite});

  factory TodoRepo.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return TodoRepo(
      id: data?['id'],
      title: data?['title'],
      createdAt: data?['createdAt'],
      isChecked: data?['isChecked'],
      isFavorite: data?['isFavorite'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (title != null) "createdAt": createdAt,
      if (title != null) "isChecked": isChecked,
      if (title != null) "isFavorite": isFavorite,
    };
  }
}

// FIX: 加工は別のところでしてもええかも
class TodoRepository {
  final db = FirebaseFirestore.instance;
  // 全件取得
  Future<List<TodoRepo>> index() async {
    final ref = db.collection('todo').withConverter<TodoRepo>(
        fromFirestore: (snapshot, _) => TodoRepo.fromFirestore(snapshot, _),
        toFirestore: (user, _) => user.toFirestore());

    final snapshot = await ref.get();
    final todos = snapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
    return todos;
  }

  // 詳細取得
  Future<TodoRepo?> show(String id) async {
    final ref = db.collection('todo').doc(id).withConverter<TodoRepo>(
        fromFirestore: TodoRepo.fromFirestore,
        toFirestore: (TodoRepo todo, _) => todo.toFirestore());
    final snap = await ref.get();
    return snap.data();
  }

  // 新規作成
  Future<void> create(String title, String uuid) async {
    await db.collection('todo').doc(uuid).set({
      "id": uuid,
      "title": title,
      "createdAt": DateTime.now(),
      "isChecked": false,
      "isFavorite": false
    });
  }
}
