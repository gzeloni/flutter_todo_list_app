import 'package:flutter/material.dart';
import 'package:todo_list/core/todo_repository.dart';
import 'package:todo_list/core/todo.dart';
import 'package:todo_list/src/widgets/todo_list_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // -----------------
  final TodoRepository todoRepository = TodoRepository();
  // -----------------
  Todo? deletedTodo;
  Todo? completedTodo;
  int? deletedTodoPos;
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
                    "Tarefas",
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
                    if (todo.isComplete == false)
                      TodoListItem(
                        todo: todo,
                        onDelete: onDelete,
                        completeTask: completeTask,
                      ),
                  if (todos.isEmpty ||
                      todos.every((element) => element.isComplete == true))
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
                              "Não há tarefas.",
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
          "Tarefa '${todo.title.length > 12 ? todo.title.substring(0, 12) : todo.title}' foi deletada!",
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

  void completeTask(Todo todo) {
    completedTodo = todo;
    setState(() {
      bool complete = true;
      todo.isComplete = complete;
    });
    todoRepository.saveTodoList(todos);
  }
}
