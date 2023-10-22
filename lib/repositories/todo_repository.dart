import 'package:menz/models/todo.dart';

class TodoRepository {
  List<Todo> todoList = [];

  List<Todo> fetchTodos() {
    // Implement your logic to fetch todos from a data source
    return todoList;
  }

  void addTodo(Todo todo) {
    // Implement your logic to add a new todo
    todoList.add(todo);
  }

  void deleteTodoAtIndex(int index) {
    // Implement your logic to delete a todo at a specific index
    if (index >= 0 && index < todoList.length) {
      todoList.removeAt(index);
    }
  }
}
