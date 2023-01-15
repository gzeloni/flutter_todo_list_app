// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  // -----------------
  final TodoRepository todoRepository = TodoRepository();
  // -----------------
  Todo? deletedTodo;
  int? deletedTodoPos;
  bool? b;
  List<Todo> todos = [];
  Duration duration = const Duration(seconds: 5);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffedebea),
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
                    "Concluídas",
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
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (Todo todo in todos)
                    if (todo.isComplete == true)
                      TodoListItem(
                        todo: todo,
                        onDelete: onDelete,
                      ),
                  if (todos.isEmpty ||
                      todos.every((element) => element.isComplete == false))
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: 20,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              "Sem tarefas concluídas.",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 8, 60, 82),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/empty.png',
                                width: 270,
                                height: 270,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
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
            if (mounted) {
              setState(() {
                todos.insert(deletedTodoPos!, deletedTodo!);
              });
              todoRepository.saveTodoList(todos);
            }
          },
        ),
        backgroundColor: Colors.white,
        duration: duration,
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
