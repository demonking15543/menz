import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final String task;

  AddTodoEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTodoEvent extends TodoEvent {
  final int index;

  DeleteTodoEvent(this.index);

  @override
  List<Object> get props => [index];
}
