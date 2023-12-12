part of 'todo_bloc.dart';

 class TodoEvent {}

 class GoToLoginEvent extends TodoEvent{}
 
 class FetchTodoApiEvent extends TodoEvent{}

 class AddTodoEvent extends TodoEvent{
  TodoModel todo;

  AddTodoEvent({required this.todo});
 }

 class DeletePostEvent extends TodoEvent {
  String id;
  DeletePostEvent({required this.id});
}