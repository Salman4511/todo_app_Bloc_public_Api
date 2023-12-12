// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:todo/models/model.dart';

class Apis {
  final baseurl = 'https://api.nstack.in/v1/todos';

  final geturl = '?page=1&limit=10';

  Future<List<TodoModel>> fetchTodoData() async {
    try {
      final response = await http.get(Uri.parse(baseurl + geturl));
      print(response.body);
      if (response.statusCode == 200) {
        final todo = jsonDecode(response.body) as Map<String, dynamic>;
        final todoList = todo['items'];
        List<TodoModel> todos = [];
        print('inside---->>');
        for (int i = 0; i < todoList.length; i++) {
          final todo = TodoModel.fromJson(todoList[i] as Map<String, dynamic>);
          todos.add(todo);
        }
              

        return todos;
      } else {
        return [];
      }
    } catch (e) {
      print('error fetch');
      log(e.toString());
      return [];
    }
  }

  Future<bool> addTodo(TodoModel todo) async {
    Map<String, dynamic> data = {
      "title": todo.title,
      "description": todo.description,
      'is_completed': 'false'
    };

    try {
     
      final response = await http.post(Uri.parse(baseurl), body: data);
      print(response.statusCode);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteTodo(String id) async {
    try {
      final response = await http.delete(Uri.parse('https://api.nstack.in/v1/todos/$id'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('data deleted successfully');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
