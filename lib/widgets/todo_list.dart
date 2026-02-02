import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import 'todo_card.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final todos = todoProvider.todos;
        debugPrint('TodoList build: ${todos.length} todos');

        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoCard(
              key: ValueKey(todo.id),
              todo: todo,
              onDelete: () => todoProvider.removeTodo(todo.id),
            );
          },
        );
      },
    );
  }
}
