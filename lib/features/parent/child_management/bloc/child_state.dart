part of 'child_bloc.dart';

abstract class ChildState extends Equatable {
  const ChildState();

  @override
  List<Object> get props => [];
}

class ChildInitial extends ChildState {}

class ChildLoading extends ChildState {}

class ChildrenLoaded extends ChildState {
  final List<ChildModel> children;

  const ChildrenLoaded(this.children);

  @override
  List<Object> get props => [children];
}

class ChildAdded extends ChildState {
  final ChildModel child;

  const ChildAdded(this.child);

  @override
  List<Object> get props => [child];
}

class ChildUpdated extends ChildState {
  final ChildModel child;

  const ChildUpdated(this.child);

  @override
  List<Object> get props => [child];
}

class ChildDeleted extends ChildState {}

class ChildError extends ChildState {
  final String message;

  const ChildError(this.message);

  @override
  List<Object> get props => [message];
}
