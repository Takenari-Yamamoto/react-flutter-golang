import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  const TodoInput(
      {super.key, required this.handleInput, required this.handleAdd});

  final void Function(String e) handleInput;
  final void Function() handleAdd;

  @override
  Widget build(context) {
    return Row(children: [
      Flexible(
          child: TextField(
        decoration: const InputDecoration(border: InputBorder.none),
        onChanged: (String text) {
          handleInput(text);
        },
      )),
      TextButton(onPressed: () => handleAdd(), child: const Text('追加'))
    ]);
  }
}
