import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.id,
    required this.title,
    required this.isChecked,
    required this.isFavorite,
    required this.onClickText,
    required this.onChangeFavorite,
    required this.onCheck,
  });

  final String id;
  final String title;
  final bool isChecked;
  final bool isFavorite;
  final void Function() onCheck;
  final void Function() onClickText;
  final void Function() onChangeFavorite;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: GestureDetector(
          onTap: () => onClickText(),
          child: Text(title,
              style: TextStyle(
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none)),
        ),
        value: isChecked,
        onChanged: (value) {
          onCheck();
        },
        controlAffinity: ListTileControlAffinity.leading,
        secondary: IconButton(
          onPressed: () => onChangeFavorite(),
          icon: const Icon(
            Icons.star,
          ),
          color: isFavorite
              ? const Color.fromARGB(255, 255, 187, 0)
              : const Color.fromARGB(255, 198, 198, 198),
        ));
  }
}
