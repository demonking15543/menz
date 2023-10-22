import 'package:flutter/material.dart';
import 'package:menz/bloc/todo_bloc.dart';
import 'package:menz/widgets/todo_input.dart';
import 'package:menz/widgets/todo_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menz/models/todo.dart';

import '../events/todo_event.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<TodoBloc, List<Todo>>(
        builder: (context, todoList) {
          return Column(
            children: <Widget>[
              TodoInput(),
              Expanded(
                child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return TodoItem(
                      task: todoList[index].task,
                      onDelete: () {
                        BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(index));
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
