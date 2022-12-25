import 'dart:async';

import "package:flutter/material.dart";
import 'package:todo_list/screens/completedTasks.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/screens/newTask/newTask.dart';
import 'package:todo_list/screens/settings.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  // declaração de variáveis
  int indexOf = 0; // posíção dos ítens na barra de navegação.
  final telas = const [
    Home(),
    CompletedTasks(),
    Settings(),
  ]; /* Botões da barra de navegação.
  Alterar essa ordem altera a posíção dos itens na barra, é um valor indexado.*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: telas[indexOf],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 32,
        selectedFontSize: 15,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xffedebea),
        unselectedItemColor: const Color.fromARGB(255, 8, 60, 82),
        selectedItemColor: const Color.fromARGB(255, 15, 158, 63),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: hideFabOnSettings(),
        child: FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: const Color.fromARGB(255, 15, 158, 63),
          onPressed: navigateSecondPage,
          label: const Text(
            'Nova Tarefa',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          icon: null,
        ),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  void navigateSecondPage() {
    Route route = MaterialPageRoute(builder: (context) => const NewTask());
    Navigator.push(context, route).then(onGoBack);
  }

  bool hideFabOnSettings() {
    if (indexOf == 2) {
      return false;
    } else {
      return true;
    }
  }
}
