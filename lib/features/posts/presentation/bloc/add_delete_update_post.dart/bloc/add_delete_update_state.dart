part of 'add_delete_update_bloc.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class LoadingAddPostState extends AddDeleteUpdateState {}

class SuccessAddPostState extends AddDeleteUpdateState {
  final String message;
  const SuccessAddPostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class ErrorAddPostState extends AddDeleteUpdateState {
  final String message;
  const ErrorAddPostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingUpDatePostState extends AddDeleteUpdateState {}

class SuccessUpDatePostState extends AddDeleteUpdateState {
  final String message;
  const SuccessUpDatePostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class ErrorUpDatePostState extends AddDeleteUpdateState {
  final String message;
  const ErrorUpDatePostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadingDeletePostState extends AddDeleteUpdateState {}

class SuccessDeletePostState extends AddDeleteUpdateState {
  final String message;
  const SuccessDeletePostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class ErrorDeletePostState extends AddDeleteUpdateState {
  final String message;
  const ErrorDeletePostState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
