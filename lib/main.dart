import 'package:flutter/material.dart';
import 'package:todo_list/navbar/navbar.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Screens(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xffedebea),
          secondary: const Color.fromARGB(255, 8, 60, 82),
        ),
      ),
    );
  }
}
