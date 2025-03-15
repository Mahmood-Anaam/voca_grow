part of 'child_bloc.dart';

abstract class ChildEvent extends Equatable {
  const ChildEvent();

  @override
  List<Object> get props => [];
}

class AddChildEvent extends ChildEvent {
  final Child child;
  final String parentId;

  const AddChildEvent(this.child, this.parentId);

  @override
  List<Object> get props => [child, parentId];
}

class UpdateChildEvent extends ChildEvent {
  final Child child;
  final String parentId;

  const UpdateChildEvent(this.child, this.parentId);

  @override
  List<Object> get props => [child, parentId];
}

class DeleteChildEvent extends ChildEvent {
  final String childId;
  final String parentId;

  const DeleteChildEvent(this.childId, this.parentId);

  @override
  List<Object> get props => [childId, parentId];
}

class LoadChildrenEvent extends ChildEvent {
  final String parentId;

  const LoadChildrenEvent(this.parentId);

  @override
  List<Object> get props => [parentId];
}