part of 'child_bloc.dart';

abstract class ChildState extends Equatable {
  const ChildState();

  @override
  List<Object> get props => [];
}

class ChildInitial extends ChildState {}

class ChildLoading extends ChildState {}

class ChildLoaded extends ChildState {
  final List<Child> children;

  const ChildLoaded(this.children);

  @override
  List<Object> get props => [children];
}

class ChildError extends ChildState {
  final String message;

  const ChildError(this.message);

  @override
  List<Object> get props => [message];
}