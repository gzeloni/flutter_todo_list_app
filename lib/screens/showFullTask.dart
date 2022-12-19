// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowFulltask extends StatelessWidget {
  ShowFulltask({
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
      backgroundColor: const Color(0xffedebea),
      appBar: AppBar(
        backgroundColor: const Color(0xffedebea),
        foregroundColor: const Color.fromARGB(255, 8, 60, 82),
        shadowColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 15,
                    ),
                    child: Text(
                      DateFormat('dd/MM/yyyy - HH:mm').format(date),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 15, 158, 63),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 8, 60, 82),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 8, 60, 82),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
