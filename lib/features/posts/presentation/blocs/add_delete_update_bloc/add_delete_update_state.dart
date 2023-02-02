part of 'add_delete_update_bloc.dart';

@immutable
abstract class AddDeleteUpdateState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AddDeleteUpdateInitial extends AddDeleteUpdateState {}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdateState {}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdateState {
  final String message;

  ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdateState {
  final String message;
  MessageAddDeleteUpdatePostState({required this.message});

  @override
  List<Object?> get props => [message];
}
