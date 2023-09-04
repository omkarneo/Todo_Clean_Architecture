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
  TodoBloc(this.getdata, this.delete, this.initDB, this.insert, this.update)
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
      Task data =
          Task(task: "Task 1", location: "123456", time: "123456", id: 1);
      var res = await delete.call(event.task);
    });
    on<UpdateTodo>((event, emit) async {
      Task data = Task(
          task: "Task 1 Update", location: "123456", time: "123456", id: 1);
      var res = await update.call(data);
      // Map data = {
      //   "Task": event.task,
      //   "Time": event.time,
      //   "Dropdown": event.location,
      // };
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // final List<String>? alltodo = prefs.getStringList('todo');
      // if (alltodo == null) {
      //   prefs.setStringList("todo", []);
      // } else {
      //   String encode = json.encode(data);
      //   alltodo[event.index] = encode;
      //   prefs.setStringList("todo", alltodo);
      // }
    });
    // on<ClearAllTodoEvent>((event, emit) async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   // Remove data for the 'counter' key.
    //   await prefs.remove('todo');
    //   List? alltodos = prefs.getStringList("todo");

    //   if (alltodos == null) {
    //     prefs.setStringList("todo", []);
    //     List? Cleardata = prefs.getStringList("todo");
    //     emit(TodoLoadedState(Cleardata!));
    //   } else {
    //     emit(TodoLoadedState(alltodos));
    //   }
    // });
  }
}
