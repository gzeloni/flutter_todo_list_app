import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/navbar/navbar.dart';
import 'package:todo_list/screens/newTask.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int id = 0;
  void refreshData() {
    id++;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => const NewTask());
    Navigator.push(context, route).then(onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Screens(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xffc38fff),
          secondary: const Color(0xffc38fff),
        ),
      ),
    );
  }
}
