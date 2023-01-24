// ignore: duplicate_ignore
// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_list/core/todo_repository.dart';
import 'package:todo_list/src/screens/navbarButtonsScreens/home.dart';
import 'package:todo_list/src/widgets/navbar/navbar.dart';
import 'package:todo_list/core/todo.dart';

class EditTask extends StatefulWidget {
  EditTask({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
  String title;
  String content;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  // -----------------
  final ScrollController scroll = ScrollController();
  final TodoRepository todoRepository = TodoRepository();
  // -----------------
  String? errorTitleText;
  String? errorSubtitleText;
  // -----------------
  List<Todo> todos = [];
  Home home = const Home();
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
    final TextEditingController titleController =
        TextEditingController(text: widget.title);
    final TextEditingController contentController =
        TextEditingController(text: widget.content);
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
                  "Editar Tarefa",
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
                    showCursor: true,
                    cursorHeight: 12,
                    cursorWidth: 2,
                    cursorColor: const Color.fromARGB(255, 8, 60, 82),
                    maxLength: 25,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: false,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 8, 60, 82),
                    ),
                    controller: titleController,
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
                    controller: contentController,
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
                      String title = titleController.text;
                      String content = contentController.text;
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
                      titleController.clear();
                      contentController.clear();
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
