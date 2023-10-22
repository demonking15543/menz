import 'package:equatable/equatable.dart';
import 'package:menz/models/todo.dart';

class TodoState extends Equatable {
  final List<Todo> todos;

  TodoState(this.todos);

  @override
  List<Object> get props => [todos];
}
