import 'package:flutter/material.dart';

enum Priority { urgent, normal, low }

class CheckableTodoItem extends StatefulWidget {
  const CheckableTodoItem(this.text, this.priority, this.description,
      {super.key});

  final String text;
  final Priority priority;
  final String description;

  @override
  State<CheckableTodoItem> createState() => _CheckableTodoItemState();
}

class _CheckableTodoItemState extends State<CheckableTodoItem> {
  var _done = false;

  void _setDone(bool? isChecked) {
    setState(() {
      _done = isChecked ?? false;
    });
  }

  void _showDialog() {
    showAdaptiveDialog(
        context: context,
        builder: (ctx) => AlertDialog(
                title: Text(widget.text),
                content: Text(widget.description),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  ),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.arrow_circle_down_outlined;

    if (widget.priority == Priority.urgent) {
      icon = Icons.circle_notifications_outlined;
    }

    if (widget.priority == Priority.normal) {
      icon = Icons.circle_outlined;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(value: _done, onChanged: _setDone),
          const SizedBox(width: 6),
          Icon(icon),
          const SizedBox(width: 12),
          TextButton(
            onPressed: _showDialog,
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 20,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
