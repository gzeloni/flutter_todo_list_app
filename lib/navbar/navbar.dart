import "package:flutter/material.dart";
import 'package:todo_list/screens/completedTasks.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/screens/newTask.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  // declaração de variáveis
  int indexOf = 0; // posíção dos ítens na barra de navegação.

  final telas = [
    Home(),
    CompletedTasks(),
  ]; /* Botões da barra de navegação.
  Alterar essa ordem altera a posíção dos itens na barra, é um valor indexado.*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: indexOf,
        children: telas,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        selectedFontSize: 15,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff121212),
        unselectedItemColor: const Color.fromARGB(255, 238, 238, 238),
        selectedItemColor: const Color.fromARGB(190, 3, 218, 197),
        currentIndex: indexOf,
        onTap: (index) => setState(() => indexOf = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Concluídas',
          ),
        ],
      ),
    );
  }
}
