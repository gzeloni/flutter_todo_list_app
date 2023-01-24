import 'package:flutter/material.dart';
import 'package:todo_list/src/widgets/navbar/navbar.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NavBar(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xffedebea),
          secondary: const Color.fromARGB(255, 8, 60, 82),
        ),
      ),
    );
  }
}
