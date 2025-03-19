part of 'child_bloc.dart';

abstract class ChildEvent extends Equatable {
  const ChildEvent();

  @override
  List<Object> get props => [];
}

class FetchChildren extends ChildEvent {}

class AddChild extends ChildEvent {
  final ChildModel child;

  const AddChild(this.child);

  @override
  List<Object> get props => [child];
}

class UpdateChild extends ChildEvent {
  final ChildModel child;

  const UpdateChild(this.child);

  @override
  List<Object> get props => [child];
}

class DeleteChild extends ChildEvent {
  final String childId;

  const DeleteChild(this.childId);

  @override
  List<Object> get props => [childId];
}
