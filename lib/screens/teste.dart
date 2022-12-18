import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/screens/home.dart';

class Teste extends StatelessWidget {
  Teste({
    Key? key,
    required this.title,
    required this.content,
    required this.date,
  }) : super(key: key);
  String title;
  String content;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e1e1e),
      appBar: AppBar(
        backgroundColor: const Color(0xff1e1e1e),
      ),
      body: Container(
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
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy - HH:mm').format(date),
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
                        content,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 221, 221, 221),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
