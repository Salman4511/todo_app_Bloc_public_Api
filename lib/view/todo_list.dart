import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc_todo/bloc/todo_bloc.dart';
import 'package:todo/view/todo_add_page.dart';
import 'package:todo/view/view_screen.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<TodoBloc>().add(FetchTodoApiEvent());
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                context.read<TodoBloc>().add(FetchTodoApiEvent());
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
       listenWhen: (previous, current) => current.hasError || current.isSuccess,
        listener: (context, state) {
          if (state.hasError || state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor:state.hasError? Colors.red:Colors.green,
            ));
          }},
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.todoList.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ScreenViewPost(post: state.todoList[index]);
                          },
                        ) as Route<Object?>,
                      );
                    },
                    title: Text(
                      state.todoList[index].title,
                    ),
                    leading: CircleAvatar(
                      child: Text((1 + index).toString()),
                    ),
                    // trailing: IconButton(
                    //   onPressed: () async {
                    //     context.read<TodoBloc>().add(DeletePostEvent(
                    //         id: state.todoList[index].id.toString()));
                    //   },
                    //   icon: const Icon(Icons.delete, color: Colors.white24),
                    // )
                    );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: state.todoList.length,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoAddScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
