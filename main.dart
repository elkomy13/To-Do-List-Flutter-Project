import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> todos = [];

  void addTodo(String todo) {
    setState(() {
      todos.add(todo);
    });
  }

  void removeTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('To-Do List App'),
        ),
        body: Column(
          children: <Widget>[
            TodoInput(onSubmit: addTodo),
            TodoList(todos: todos, onRemove: removeTodo),
          ],
        ),
      ),
    );
  }
}

class TodoInput extends StatefulWidget {
  final Function onSubmit;

  TodoInput({required this.onSubmit});

  @override
  _TodoInputState createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmit() {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmit(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'New Todo',
              ),
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _handleSubmit,
          )
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final List<String> todos;
  final Function(int) onRemove;

  TodoList({required this.todos, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => onRemove(index),
            ),
          );
        },
      ),
    );
  }
}
