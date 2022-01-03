import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/modules/todo/repositories/todo_repository.dart';
import 'package:firebase_crud/modules/todo/todo_model.dart';

class TodoFirebaseRepository implements TodoRepository {
  final FirebaseFirestore _firestore;

  TodoFirebaseRepository(this._firestore);

  @override
  Stream<List<TodoModel>> getTodo() {
    return _firestore
        .collection('todos')
        .orderBy('todo', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => TodoModel.fromDocument(e)).toList();
    });
  }

  @override
  Future<void> saveTodo(Map<String, dynamic> todo) async {
    try {
      await _firestore.collection('todos').add(todo);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    try {
      await todo.reference.update({'isSelected': todo.isSelected});
    } catch (e) {
      rethrow;
    }
  }
}
