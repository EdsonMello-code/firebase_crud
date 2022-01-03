import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/modules/todo/todo_controller.dart';
import 'package:firebase_crud/modules/todo/todo_model.dart';
import 'package:firebase_crud/modules/todo/repositories/todo_firebase_repository.dart';
import 'package:flutter/material.dart';

class TodoView extends StatefulWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  TodoViewState createState() => TodoViewState();
}

class TodoViewState extends State<TodoView> {
  late final TodoController _todoController;
  late final TextEditingController _inputController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    _todoController = TodoController(
      TodoFirebaseRepository(FirebaseFirestore.instance),
    );
    _inputController = TextEditingController();
    _focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveTodo() async {
    {
      if (_inputController.text.isNotEmpty) {
        await _todoController.saveTodo(
          {
            'todo': _inputController.text,
            'isSelected': false,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 50.0, left: 16, right: 16),
              child: TextField(
                focusNode: _focusNode,
                controller: _inputController,
                onSubmitted: (_) async {
                  await _handleSaveTodo();
                  _focusNode.unfocus();
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: _handleSaveTodo,
                  icon: const Icon(
                    Icons.add,
                  ),
                )),
              ),
            ),
            StreamBuilder<List<TodoModel>>(
              stream: _todoController.list,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return _buildListTile(snapshot.data![index]);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(TodoModel selectedTodo) {
    return CheckboxListTile(
      title: Text(
        selectedTodo.todo,
        style: TextStyle(
          color: Colors.blue,
          decoration: selectedTodo.isSelected
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: selectedTodo.isSelected,
      onChanged: (value) async {
        if (value != null) {
          selectedTodo.isSelected = value;
          await _todoController.updateTodo(selectedTodo);
        }
      },
    );
  }
}
