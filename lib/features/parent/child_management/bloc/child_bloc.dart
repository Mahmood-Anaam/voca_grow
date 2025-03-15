import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repositories/child_repository.dart';
import '../data/models/child_model.dart';

part 'child_event.dart';
part 'child_state.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState> {
  final ChildRepository childRepository;

  ChildBloc(this.childRepository) : super(ChildInitial()) {
    on<AddChildEvent>(_onAddChild);
    on<UpdateChildEvent>(_onUpdateChild);
    on<DeleteChildEvent>(_onDeleteChild);
    on<LoadChildrenEvent>(_onLoadChildren);
  }

  Future<void> _onAddChild(
    AddChildEvent event,
    Emitter<ChildState> emit,
  ) async {
    emit(ChildLoading());
    try {
      await childRepository.addChild(event.child, event.parentId);
      emit(ChildLoaded(await childRepository.getChildren(event.parentId)));
    } catch (e) {
      emit(ChildError(e.toString()));
    }
  }

  Future<void> _onUpdateChild(
    UpdateChildEvent event,
    Emitter<ChildState> emit,
  ) async {
    emit(ChildLoading());
    try {
      await childRepository.updateChild(event.child, event.parentId);
      emit(ChildLoaded(await childRepository.getChildren(event.parentId)));
    } catch (e) {
      emit(ChildError(e.toString()));
    }
  }

  Future<void> _onDeleteChild(
    DeleteChildEvent event,
    Emitter<ChildState> emit,
  ) async {
    emit(ChildLoading());
    try {
      await childRepository.deleteChild(event.childId, event.parentId);
      emit(ChildLoaded(await childRepository.getChildren(event.parentId)));
    } catch (e) {
      emit(ChildError(e.toString()));
    }
  }

  Future<void> _onLoadChildren(
    LoadChildrenEvent event,
    Emitter<ChildState> emit,
  ) async {
    emit(ChildLoading());
    try {
      final children = await childRepository.getChildren(event.parentId);
      emit(ChildLoaded(children));
    } catch (e) {
      emit(ChildError(e.toString()));
    }
  }
}
