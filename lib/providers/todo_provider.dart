import 'package:flutter/foundation.dart';
import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  TodoProvider() {
    _todos.addAll([
      Todo(
        title: 'Make User Stories',
        description: 'Make user stories for project No.1 and project No.5.',
      ),
      Todo(
        title: 'Create Mood board',
        description: 'Make user stories for project No.1 and project No.5.',
      ),
      Todo(
        title: 'Create a loom giving a walkthrough of the design.',
        description: 'Make user stories for project No.1 and project No.5.',
      ),
    ]);
  }

  void addTodo(String title, String description) {
    _todos.insert(0, Todo(title: title, description: description));
    notifyListeners();
  }

  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void toggleComplete(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(isCompleted: !_todos[index].isCompleted);
      notifyListeners();
    }
  }

  void updateTodo(String id, String title, String description) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(title: title, description: description);
      notifyListeners();
    }
  }
}
