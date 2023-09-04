import 'package:get_it/get_it.dart';
import 'package:todo_with_cleanarch/features/todo/data/repo_implementation/todoim.dart';
import 'package:todo_with_cleanarch/features/todo/presentation/bloc/todo_bloc.dart';

import 'features/todo/domain/repo/todoab.dart';
import 'features/todo/domain/usecase/usecase.dart';

final GetIt locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerFactory<TodoBloc>(() => TodoBloc(
      GetDataUseCase(locator<Todoab>()),
      DeleteDataUseCase(locator<Todoab>()),
      InItUseCase(locator<Todoab>()),
      InsertDataUseCase(locator<Todoab>()),
      UpdateDataUseCase(locator<Todoab>())));

  locator.registerLazySingleton<Todoab>(() => TodoIm());
}
