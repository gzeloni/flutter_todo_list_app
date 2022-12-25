// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowFulltask extends StatefulWidget {
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
  State<ShowFulltask> createState() => _ShowFulltaskState();
}

class _ShowFulltaskState extends State<ShowFulltask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedebea),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
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
                      bottom: 10,
                    ),
                    child: Text(
                      DateFormat('dd/MM/yyyy - HH:mm').format(widget.date),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 15, 158, 63),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 0.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        widget.content,
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
