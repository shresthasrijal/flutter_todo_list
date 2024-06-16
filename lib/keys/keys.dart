import 'package:flutter/material.dart';
import 'package:proj5_todo_app_keys/keys/checkable_todo_item.dart';
import 'package:proj5_todo_app_keys/overlayContent.dart';
// import 'package:proj5_todo_app_keys/keys/todo_item.dart';

class Todo {
  const Todo(this.text, this.priority, this.description);

  final String text;
  final Priority priority;
  final String description;
}

class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

class _KeysState extends State<Keys> {
  var _order = 'asc';
  final List<Todo> _todos = [];

  void _openModalOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return OverlayContent(_todos, _changeOrder);
      },
    );
  }

  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No items found in To Do List. Start adding some!"),
    );

    if (_todos.isNotEmpty) {
      mainContent = Column(
        children: _orderedTodos.map((todo) {
          return Dismissible(
            key: ValueKey(todo.text),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(8,8,24,8),
                child: Icon(
                  Icons.remove_circle_outline_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                _orderedTodos.remove(todo);
                _todos.remove(todo);
              });
            },
            child: CheckableTodoItem(
              todo.text,
              todo.priority,
              todo.description,
            ),
          );
        }).toList(),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                _openModalOverlay();
              },
              icon: const Icon(Icons.add),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: _changeOrder,
              icon: Icon(
                _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
              ),
              label:
                  Text('Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'),
            ),
          ],
        ),
        Expanded(
          child: mainContent,
        ),
      ],
    );
  }
}
