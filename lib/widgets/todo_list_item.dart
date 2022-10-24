import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/widgets/todo.dart';

class TodoListItem extends StatelessWidget {
  // -----------------
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onDelete,
  });
  // -----------------
  final Todo todo;
  final Function(Todo) onDelete;
  // -----------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      child: Slidable(
        useTextDirection: true,
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete(todo);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff1e1e1e),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy - HH:mm').format(todo.date),
                    style: const TextStyle(
                      color: Color.fromARGB(218, 212, 212, 212),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    todo.title,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 245, 245, 245),
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
