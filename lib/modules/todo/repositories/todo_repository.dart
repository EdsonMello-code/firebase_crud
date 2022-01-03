import 'package:firebase_crud/modules/todo/todo_model.dart';

abstract class TodoRepository {
  const TodoRepository();

  Stream<List<TodoModel>> getTodo();

  Future<void> saveTodo(Map<String, dynamic> todo);
  Future<void> updateTodo(TodoModel todo);
}
