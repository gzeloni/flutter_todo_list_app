import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/todo.dart';

const todoListKey = 'todo_list7';

class TodoRepository {
  late SharedPreferences sharedPreferences;

  void saveTodoList(List<Todo> todos) {
    final String jsonString = json.encode(todos);
    sharedPreferences.setString(todoListKey, jsonString);
  }

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }
}
