import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/glassmorphic_container.dart';
import '../widgets/add_button.dart';
import '../widgets/todo_list.dart';

class TodoWidgetScreen extends StatelessWidget {
  const TodoWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: 280,
      height: 380,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's To Do",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Text(
            'Add a list of all the tasks due today',
            style: TextStyle(
              color: Color(0xFFB0B0B0),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          _InputSection(),
          const SizedBox(height: 16),
          const Expanded(
            child: TodoList(),
          ),
        ],
      ),
    );
  }
}

class _InputSection extends StatefulWidget {
  @override
  State<_InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends State<_InputSection> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTextChanged);
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_showError && _titleController.text.trim().isNotEmpty) {
      setState(() => _showError = false);
    }
  }

  void _handleAdd() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      setState(() => _showError = true);
      _titleFocusNode.requestFocus();
      return;
    }

    context.read<TodoProvider>().addTodo(title, description);
    _titleController.clear();
    _descriptionController.clear();
    _titleFocusNode.requestFocus();
    setState(() => _showError = false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(26, 26, 46, 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromRGBO(255, 255, 255, 0.05),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  focusNode: _titleFocusNode,
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
          ),
        ),
        const SizedBox(width: 12),
        AddButton(onPressed: _handleAdd),
      ],
    );
  }
}
