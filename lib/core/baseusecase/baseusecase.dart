import 'package:equatable/equatable.dart';

abstract class BaseUseCase<Type, Params> {
  Future call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
