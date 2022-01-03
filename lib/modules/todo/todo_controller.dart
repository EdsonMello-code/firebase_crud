import 'package:firebase_crud/modules/todo/repositories/todo_repository.dart';
import 'package:firebase_crud/modules/todo/todo_model.dart';

class TodoController {
  final TodoRepository _todoRepository;
  late Stream<List<TodoModel>> list;

  TodoController(this._todoRepository) {
    getTodos();
  }

  getTodos() {
    list = _todoRepository.getTodo();
  }

  Future<void> saveTodo(Map<String, dynamic> todo) async {
    await _todoRepository.saveTodo(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _todoRepository.updateTodo(todo);
  }
}
