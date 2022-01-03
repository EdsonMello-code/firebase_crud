import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  // bool isSelected;
  final String todo;
  bool isSelected;
  final DocumentReference reference;

  TodoModel({
    required this.todo,
    this.isSelected = false,
    required this.reference,
  });

  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map;
    return TodoModel(
      reference: doc.reference,
      todo: data['todo'],
      isSelected: data['isSelected'],
    );
  }

  toMap() {
    return {
      'todo': todo,
      'isSelected': isSelected,
    };
  }
}
