import 'package:flutter/material.dart';
import 'package:proj5_todo_app_keys/keys/keys.dart';
import 'package:proj5_todo_app_keys/keys/checkable_todo_item.dart';

class OverlayContent extends StatefulWidget {
  const OverlayContent(this.todos, this.func, {super.key});

  final List<Todo> todos;
  final Function func;

  @override
  State<OverlayContent> createState() {
    return _OverlayContentState();
  }
}

class _OverlayContentState extends State<OverlayContent> {
  final _titleController = TextEditingController();
  Priority _selectedPriority = Priority.low;
  final _descriptionController = TextEditingController();

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Invalid Input"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'))
        ],
      ),
    );
  }

  bool _isDuplicate(String title) {
    return widget.todos
        .any((todo) => todo.text == title);
  }

  void _submitted() {
    if (_titleController.text.trim().isEmpty) {
      _showDialog(
          "Please sure that a valid title, priority, and description was entered.");
      return;
    }
    if (_isDuplicate(
        _titleController.text.trim())) {
      _showDialog("This todo item already exists.");
      return;
    }
    widget.todos.add(Todo(_titleController.text, _selectedPriority, _descriptionController.text));
    widget.func();
    Navigator.pop(context);
  }

  Widget _titleInput() {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Title')),
    );
  }

  Widget _descInput() {
    return TextField(
      controller: _descriptionController,
      maxLength: 150,
      maxLines: 4,
      decoration: const InputDecoration(
        label: Text('Description'),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _dropdowninput() {
    return DropdownButton(
        value: _selectedPriority,
        items: Priority.values
            .map(
              (priority) => DropdownMenuItem(
                value: priority,
                child: Text(priority.name.toUpperCase()),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            _selectedPriority = value;
          });
        });
  }

  @override
  Widget build(context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardspace + 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _titleInput(),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(child: _dropdowninput()),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                _descInput(),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Discard'),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      onPressed: _submitted,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
