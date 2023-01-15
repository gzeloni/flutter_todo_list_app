// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_list/navbar/navbar.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  // -----------------
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final ScrollController scroll = ScrollController();
  final TodoRepository todoRepository = TodoRepository();
  // -----------------
  Todo? deletedTodo;
  int? deletedTodoPos;
  String? errorTitleText;
  String? errorSubtitleText;
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
    _subtitleController.dispose();
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 25,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: false,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 8, 60, 82),
                    ),
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 8, 60, 82),
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 8, 60, 82),
                      ),
                      filled: true,
                      fillColor: const Color(0xffedebea),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 8, 60, 82),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 15, 158, 63),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 15, 158, 63),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 8, 60, 82),
                      ),
                      labelText: "Dê um título a tarefa",
                      hintText: "Ex: Estudar piano",
                      errorText: errorTitleText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 8, 60, 82),
                    ),
                    controller: _subtitleController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 8, 60, 82),
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 8, 60, 82),
                      ),
                      filled: true,
                      fillColor: const Color(0xffedebea),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 8, 60, 82),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 15, 158, 63),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 15, 158, 63),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 8, 60, 82),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      labelText: "Conteúdo",
                      alignLabelWithHint: true,
                      hintText: "Ex: Estudar piano às 14:00",
                      errorText: errorSubtitleText,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      String content = _subtitleController.text;
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
                          errorSubtitleText =
                              'O conteúdo não pode estar vazio.';
                        });
                        return;
                      } else {
                        setState(() {
                          errorSubtitleText = null;
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
                      _subtitleController.clear();
                      todoRepository.saveTodoList(todos);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const Screens()),
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
