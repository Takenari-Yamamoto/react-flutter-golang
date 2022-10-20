class TodoEntity {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const TodoEntity(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }
}
