import 'package:flutter/material.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  // -----------------
  final TextEditingController todoController = TextEditingController();
  final ScrollController scroll = ScrollController();
  final TodoRepository todoRepository = TodoRepository();
  // -----------------
  Todo? deletedTodo;
  int? deletecTodoPos;
  String? errorText;
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
              padding: const EdgeInsets.only(top: 30, bottom: 20),
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(
                        color: Color.fromARGB(255, 245, 245, 245),
                      ),
                      controller: todoController,
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
                        labelText: "Adicione uma tarefa",
                        hintText: "Ex: Estudar Flutter",
                        errorText: errorText,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffc38fff),
                      padding: const EdgeInsets.all(17),
                    ),
                    onPressed: () {
                      String text = todoController.text;
                      if (text.isEmpty) {
                        setState(() {
                          errorText = 'O título não pode estar vazio.';
                        });
                        return;
                      }
                      setState(() {
                        Todo newTodo = Todo(
                          date: DateTime.now(),
                          title: text,
                        );
                        todos.add(newTodo);
                        errorText = null;
                      });
                      todoController.clear();
                      todoRepository.saveTodoList(todos);
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
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
          backgroundColor: const Color(0xff03dac6),
          onPressed: showDeleteTodosConfirmationDialog,
          label: const Text(
            'Deletar Tudo',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          icon: const Icon(
            Icons.delete,
            size: 25,
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletecTodoPos = todos.indexOf(todo);
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
              todos.insert(deletecTodoPos!, deletedTodo!);
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
        backgroundColor: const Color(0xff1e1e1e),
        title: const Text(
          "Deseja deletar tudo?",
          style: TextStyle(
            color: Color.fromARGB(255, 245, 245, 245),
          ),
        ),
        content: const Text(
          "Você tem certeza que deseja deletar tudo? Essa ação não poderá ser desfeita.",
          style: TextStyle(
            color: Color.fromARGB(255, 245, 245, 245),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancelar",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xffc38fff),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            child: const Text(
              "Limpar tudo",
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
    todoRepository.saveTodoList(todos);
  }
}
