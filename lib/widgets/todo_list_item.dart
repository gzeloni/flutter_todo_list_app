import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/screens/teste.dart';
import 'package:todo_list/widgets/circular_button.dart';
import 'package:todo_list/widgets/todo.dart';

class TodoItem extends StatelessWidget {
  // -----------------
  TodoItem({
    super.key,
    required this.todo,
    required this.onDelete,
  });
  // -----------------
  final Todo todo;
  final Function(Todo) onDelete;
  // -----------------
  bool changeIcon = false;
  // -----------------

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Teste(
                title: todo.title,
                content: todo.content,
                date: todo.date,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xff1e1e1e),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      todo.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy - HH:mm').format(todo.date),
                      style: const TextStyle(
                        color: Color.fromARGB(218, 212, 212, 212),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          todo.content,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 221, 221, 221),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    CircularButton(onPressed: () {
                      changeIcon = !changeIcon;
                      todo.isComplete = changeIcon;
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color(0xff1e1e1e),
              title: const Text(
                "Deletar Tarefa",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 221, 221, 221),
                ),
              ),
              content: const Text(
                "Deseja mesmo deletar essa tarefa?",
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 221, 221, 221),
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
                            color: Color.fromARGB(190, 3, 218, 197),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          onDelete(todo);
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
        },
      ),
    );
  }
}
