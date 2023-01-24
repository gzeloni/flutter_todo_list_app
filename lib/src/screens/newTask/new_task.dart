// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_list/core/todo_repository.dart';
import 'package:todo_list/src/widgets/navbar/navbar.dart';
import 'package:todo_list/core/todo.dart';
import 'package:todo_list/src/widgets/taskFields/content_field.dart';
import 'package:todo_list/src/widgets/taskFields/title_field.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  // -----------------
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final ScrollController scroll = ScrollController();
  final TodoRepository todoRepository = TodoRepository();
  // -----------------
  String? errorTitleText;
  String? errorContentText;
  // -----------------
  List<Todo> todos = [];
  // -----------------
  @override
  void initState() {
    super.initState();
    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  String hashEncoder() {
    String time = DateTime.now().toIso8601String();
    final bytes = utf8.encode(time);
    String id = base64.encode(bytes);
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedebea),
      body: SafeArea(
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Nova Tarefa",
                  style: TextStyle(
                    fontSize: 28,
                    color: Color.fromARGB(255, 8, 60, 82),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TitleField(
            titleController: _titleController,
            errorTitleText: errorTitleText,
          ),
          const SizedBox(
            height: 12,
          ),
          ContentField(
              contentController: _contentController,
              errorContentText: errorContentText),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      String title = _titleController.text;
                      String content = _contentController.text;
                      if (title.isEmpty) {
                        setState(() {
                          errorTitleText = 'O título não pode estar vazio.';
                        });
                        return;
                      } else {
                        setState(() {
                          errorTitleText = null;
                        });
                      }
                      if (content.isEmpty) {
                        setState(() {
                          errorContentText = 'O conteúdo não pode estar vazio.';
                        });
                        return;
                      } else {
                        setState(() {
                          errorContentText = null;
                        });
                      }

                      Todo newTodo = Todo(
                        date: DateTime.now(),
                        id: hashEncoder().toString(),
                        title: title,
                        content: content,
                        isComplete: false,
                      );
                      todos.add(newTodo);
                      _titleController.clear();
                      _contentController.clear();
                      todoRepository.saveTodoList(todos);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const NavBar()),
                      );
                    });
                  },
                  child: const Text(
                    "Adicionar",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 15, 158, 63),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
