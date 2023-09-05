part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoLoadEvent extends TodoEvent {}

class CreateTodo extends TodoEvent {
  final data;

  // final String task;
  // final String location;
  // final String time;

  const CreateTodo(this.data);
  List<Object> get props => [data];
}

class DeleteTodo extends TodoEvent {
  final task;

  const DeleteTodo(this.task);
  List<Object> get props => [task];
}

class ClearAllTodoEvent extends TodoEvent {
  List<Object> get props => [];
}

class UpdateTodo extends TodoEvent {
  final task;

  const UpdateTodo(this.task);
  List<Object> get props => [task];
}
