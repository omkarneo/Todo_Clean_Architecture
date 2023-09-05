import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/task.dart';
import '../../domain/usecase/usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetDataUseCase getdata;
  final InItUseCase initDB;
  final InsertDataUseCase insert;
  final DeleteDataUseCase delete;
  final UpdateDataUseCase update;
  final AllDataDeleteUseCase allclear;
  TodoBloc(this.getdata, this.delete, this.initDB, this.insert, this.update,
      this.allclear)
      : super(TodoInitial()) {
    on<TodoLoadEvent>((event, emit) async {
      var res = getdata.call("");
      // print(res);
      emit(TodoLoadedState(res));
      // print(res);
    });
    on<CreateTodo>((event, emit) async {
      // Task data = Task(task: "Task 1", location: "123456", time: "123456");
      var res = await insert.call(event.data);
      print(res);
    });
    on<DeleteTodo>((event, emit) async {
      var res = await delete.call(event.task);
    });
    on<UpdateTodo>((event, emit) async {
      var res = await update.call(event.task);
    });
    on<ClearAllTodoEvent>((event, emit) async {
      await allclear.call("");
    });
  }
}
