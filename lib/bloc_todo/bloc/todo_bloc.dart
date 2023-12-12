import 'package:bloc/bloc.dart';
import 'package:todo/api_functions/api.dart';

import 'package:todo/models/model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    final apis = Apis();

    on<FetchTodoApiEvent>((event, emit) async {
      emit(TodoState(todoList: [], isLoading: true));
      final todos = await apis.fetchTodoData();
      emit(TodoState(todoList: todos, isLoading: false));
    });

    on<AddTodoEvent>((event, emit) async {
      emit(TodoState(todoList: [], isAdding: true, isLoading: true));
      bool success = await apis.addTodo(event.todo);
      final todos = await apis.fetchTodoData();
      if (success) {
        emit(TodoState(
            todoList: todos,
            isLoading: false,
            isAdding: false,
            isSuccess: success,
            message: 'Added succesfully'));
      } else {
        emit(TodoState(
            todoList: todos,
            isLoading: false,
            isAdding: false,
            hasError: true,
            message:  'Not Added'));
      }
    });

    //  on<DeletePostEvent>((event, emit) async {
    //   emit(TodoState(todoList: [], isLoading: true, isDeleted: true));
    //   await apis.deleteTodo(event.id);
    //   final List<TodoModel> posts = await apis.fetchTodoData();
    //   emit(TodoState(todoList: posts, isLoading: false, isDeleted: false));
    // });
  }
}
