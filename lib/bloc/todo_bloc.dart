import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:menz/events/todo_event.dart';
import 'package:menz/models/todo.dart';
import 'package:menz/repositories/todo_repository.dart';
import 'package:menz/states/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, List<Todo>> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super([]);

  @override
  Stream<List<Todo>> mapEventToState(TodoEvent event) async* {
    if (event is AddTodoEvent) {
      List<Todo> newTodos = List.from(state);
      newTodos.add(Todo(event.task));
      yield newTodos;
    } else if (event is DeleteTodoEvent) {
      List<Todo> newTodos = List.from(state);
      newTodos.removeAt(event.index);
      yield newTodos;
    }
  }
}
