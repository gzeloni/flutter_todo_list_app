import 'package:flutter/material.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TodoRepository todoRepository = TodoRepository();
  List<Todo> todos = [];

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
                    "Configurações",
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
            if (todos.isEmpty)
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "A opção de deletar todas as tarefas só aparece quando há novas tarefas ou tarefas concluídas.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 8, 60, 82),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (todos.every((e) => e.isComplete == false) && todos.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: TextButton(
                    onPressed: deleteTodos,
                    child: const Text(
                      "Deletar novas tarefas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            if (todos.every((e) => e.isComplete == true) && todos.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: TextButton(
                    onPressed: deleteTodos,
                    child: const Text(
                      "Deletar tarefas concluídas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            if (todos.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: TextButton(
                    onPressed: deleteTodos,
                    child: const Text(
                      "Deletar todas as tarefas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void deleteTodos() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xffedebea),
        title: const Text(
          "Deletar Tudo",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 8, 60, 82),
          ),
        ),
        content: const Text(
          "Deseja mesmo deletar todas as tarefas?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 8, 60, 82),
          ),
        ),
        actions: <Widget>[
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
                      color: Color.fromARGB(255, 15, 158, 63),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      todos.clear();
                      todoRepository.saveTodoList(todos);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Deletar",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
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
}
