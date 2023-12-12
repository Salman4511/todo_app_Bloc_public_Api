// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc_todo/bloc/todo_bloc.dart';
import 'package:todo/core/constraints.dart';
import 'package:todo/models/model.dart';

class TodoAddScreen extends StatelessWidget {
  TodoAddScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Todo',
          style: titletxtsyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              kheight,
              TextFormField(
                controller: bodyController,
                decoration: const InputDecoration(hintText: 'Description'),
                minLines: 7,
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              kheight20,
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(themeprimary),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final todo = TodoModel(
                        title: titleController.text,
                        description: bodyController.text,
                      );

                     
                     
                      context.read<TodoBloc>().add(AddTodoEvent(todo: todo));
                       print('log------------------------>>>>>>');

                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: titletxtsyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
