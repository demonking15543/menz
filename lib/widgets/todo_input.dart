import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menz/bloc/todo_bloc.dart';
import 'package:menz/events/todo_event.dart';

class TodoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(value));
            controller.clear();
          }
        },
        decoration: InputDecoration(
          hintText: 'Enter task',
        ),
      ),
    );
  }
}
