import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String task;
  final VoidCallback onDelete;
  final Key? key;

  const TodoItem({required this.task, required this.onDelete, this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
