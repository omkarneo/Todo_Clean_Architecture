import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      emit(TodoLoadedState(res));
    });
    on<CreateTodo>((event, emit) async {
      await insert.call(event.data);
    });
    on<DeleteTodo>((event, emit) async {
      await delete.call(event.task);
    });
    on<UpdateTodo>((event, emit) async {
      await update.call(event.task);
    });
    on<ClearAllTodoEvent>((event, emit) async {
      await allclear.call("");
    });
  }
}
