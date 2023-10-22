import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Map<String, dynamic>> _todoList = [];
  final TextEditingController _textFieldController = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yy hh:mm:ss a');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(_todoList[index]['title']),
              subtitle:_todoList[index]['reminder'] != null
                  ? CountdownDisplay(
                      targetDate: _todoList[index]['reminder'],
                      dateFormatter: _dateFormat,
                    )
                  : const Text('No Reminder'),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _displayEditDialog(context, index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _removeTodoItem(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(context),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title, DateTime? reminder) {
    setState(() {
      _todoList.add({'title': title, 'reminder': reminder});
    });
    _textFieldController.clear();
    _showSnackBar('New task added: $title');
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
    _showSnackBar('Task Deleted');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _displayDialog(BuildContext context) async {
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Add a task to your list'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(hintText: 'Enter task here'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {});
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        setState(() {});
                      }
                    },
                    child: const Text('Select Time'),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('ADD'),
                  onPressed: () {
                    DateTime? reminder;
                    if (selectedDate != null && selectedTime != null) {
                      reminder = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );
                    }
                    _addTodoItem(_textFieldController.text, reminder);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _displayEditDialog(BuildContext context, int index) async {
    _textFieldController.text = _todoList[index]['title'];
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit your task'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Edit task here'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('EDIT'),
              onPressed: () {
                setState(() {
                  _todoList[index]['title'] = _textFieldController.text;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}


class CountdownDisplay extends StatefulWidget {
  final DateTime targetDate;
  final DateFormat dateFormatter;

  const CountdownDisplay({
    required this.targetDate,
    required this.dateFormatter,
  });

  @override
  _CountdownDisplayState createState() => _CountdownDisplayState();
}

class _CountdownDisplayState extends State<CountdownDisplay> {
  late Duration _timeUntil;

  @override
  void initState() {
    super.initState();
    _timeUntil = widget.targetDate.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _timeUntil = widget.targetDate.difference(DateTime.now());
        _startTimer();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time Left: ${_formattedTime(_timeUntil)}',
    );
  }

  String _formattedTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
