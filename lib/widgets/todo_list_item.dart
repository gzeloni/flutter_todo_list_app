import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/screens/showFullTask.dart';
import 'package:todo_list/widgets/circular_button.dart';
import 'package:todo_list/widgets/todo.dart';

class TodoListItem extends StatelessWidget {
  // -----------------
  TodoListItem({
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
              builder: (context) => ShowFulltask(
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
            color: const Color(0xffedebea),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              width: 1.6,
              color: Color.fromARGB(134, 136, 136, 136),
            ),
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
                      todo.title.length > 12
                          ? todo.title.substring(0, 12)
                          : todo.title,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 8, 60, 82),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy - HH:mm').format(todo.date),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 15, 158, 63),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
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
                          todo.content.length > 25
                              ? todo.content.substring(0, 25)
                              : todo.content,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 8, 60, 82),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    CircularButton(onPressed: () {})
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
              backgroundColor: const Color(0xffedebea),
              title: const Text(
                "Deletar Tarefa",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 8, 60, 82),
                ),
              ),
              content: const Text(
                "Deseja mesmo deletar essa tarefa?",
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
