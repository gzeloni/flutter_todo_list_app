import 'package:flutter/material.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // -----------------
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff121212),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Tarefas",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color.fromARGB(255, 245, 245, 245),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (Todo todo in todos)
                    TodoListItem(todo: todo, onDelete: onDelete),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(190, 3, 218, 197),
          onPressed: showDeleteTodosConfirmationDialog,
          label: const Text(
            'Nova Tarefa',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          icon: const Icon(
            Icons.add,
            size: 25,
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);
    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa '${todo.title}' foi deletada!",
          style: const TextStyle(
            color: Color.fromARGB(228, 22, 22, 22),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
            todoRepository.saveTodoList(todos);
          },
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        backgroundColor: const Color(0xff1e1e1e),
        title: const Text(
          "Nova Tarefa",
          style: TextStyle(
            color: Color.fromARGB(255, 245, 245, 245),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: false,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 245, 245, 245),
                    ),
                    controller: titleController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 245, 245, 245),
                      ),
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 245, 245, 245),
                      ),
                      filled: true,
                      fillColor: const Color(0xff1e1e1e),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color(0xffc38fff),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color(0xffc38fff),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color(0xffc38fff),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: Color(0xffc38fff),
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
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 245, 245, 245),
                      ),
                      controller: subtitleController,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 245, 245, 245),
                        ),
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 245, 245, 245),
                        ),
                        filled: true,
                        fillColor: const Color(0xff1e1e1e),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color(0xff121212),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color(0xff121212),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Color(0xff121212),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 238, 238, 238),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        labelText: "Conteúdo",
                        hintText: "Ex: Estudar piano às 14:00",
                        errorText: errorSubtitleText,
                      ),
                    ),
                  ),
                ],
              ),
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
                    String title = titleController.text;
                    String subtitle = subtitleController.text;
                    if (title.isEmpty) {
                      setState(() {
                        errorTitleText = 'O título não pode estar vazio.';
                      });
                      return;
                    }
                    if (subtitle.isEmpty) {
                      setState(() {
                        errorSubtitleText = 'O subtitulo não pode estar vazio.';
                      });
                      return;
                    }
                    setState(() {
                      Todo newTodo = Todo(
                        date: DateTime.now(),
                        title: title,
                        subtitle: subtitle,
                      );
                      todos.add(newTodo);
                      errorTitleText = null;
                      errorSubtitleText = null;
                      titleController.clear();
                      subtitleController.clear();
                      todoRepository.saveTodoList(todos);
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text(
                    "Adicionar",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff03dac6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addNewTodo() {}

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
    todoRepository.saveTodoList(todos);
  }
}
