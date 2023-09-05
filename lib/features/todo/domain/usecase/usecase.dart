import 'package:todo_with_cleanarch/core/baseusecase/baseusecase.dart';

import '../enitites/task.dart';
import '../repo/todoab.dart';

class InItUseCase extends BaseUseCase {
  final Todoab todo;
  InItUseCase(this.todo);
  @override
  Future call(params) {
    return todo.initDB();
  }
}

class GetDataUseCase extends BaseUseCase {
  final Todoab todo;
  GetDataUseCase(this.todo);
  @override
  Future call(params) {
    return todo.getData();
  }
}

class InsertDataUseCase extends BaseUseCase {
  final Todoab todo;
  InsertDataUseCase(this.todo);
  @override
  Future call(params) {
    return todo.insertData(params);
  }
}

class DeleteDataUseCase extends BaseUseCase {
  final Todoab todo;
  DeleteDataUseCase(this.todo);
  @override
  Future call(params) {
    return todo.deleteData(params);
  }
}

class UpdateDataUseCase extends BaseUseCase {
  final Todoab todo;
  UpdateDataUseCase(this.todo);
  @override
  Future call(params) {
    return todo.updateData(params);
  }
}

class AllDataDeleteUseCase extends BaseUseCase {
  final Todoab todo;
  AllDataDeleteUseCase(this.todo);
  @override
  Future call(params) {
    return todo.alldelete();
  }
}
