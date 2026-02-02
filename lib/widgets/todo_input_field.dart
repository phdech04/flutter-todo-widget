import 'package:flutter/material.dart';

class TodoInputField extends StatefulWidget {
  final void Function(String title, String description) onAdd;

  const TodoInputField({
    super.key,
    required this.onAdd,
  });

  @override
  State<TodoInputField> createState() => _TodoInputFieldState();
}

class _TodoInputFieldState extends State<TodoInputField> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleAdd() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      widget.onAdd(title, description);
      _titleController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(26, 26, 46, 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Title...',
              hintStyle: TextStyle(color: Color(0xFF808080)),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
            ),
            onSubmitted: (_) => _handleAdd(),
          ),
          TextField(
            controller: _descriptionController,
            style: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 12),
            decoration: const InputDecoration(
              hintText: 'About...',
              hintStyle: TextStyle(color: Color(0xFF808080), fontSize: 12),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
            ),
            onSubmitted: (_) => _handleAdd(),
          ),
        ],
      ),
    );
  }
}
