import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_list/core/hide_fab.dart';
import 'package:todo_list/src/screens/navbarButtonsScreens/completedTasks.dart';
import 'package:todo_list/src/screens/navbarButtonsScreens/home.dart';
import 'package:todo_list/src/screens/navbarButtonsScreens/settings.dart';
import 'package:todo_list/src/screens/newTask/newTask.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int indexOf = 0;
  final hideFab = HideFab();
  final telas = const [
    Home(),
    CompletedTasks(),
    Settings(),
  ];

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
        visible: hideFab.hideFabOnSettings(indexOf),
        child: FloatingActionButton.extended(
          heroTag: null,
          backgroundColor: const Color.fromARGB(255, 15, 158, 63),
          onPressed: newTask,
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

  void newTask() {
    Route route = MaterialPageRoute(builder: (context) => const NewTask());
    Navigator.push(context, route).then(onGoBack);
  }
}
