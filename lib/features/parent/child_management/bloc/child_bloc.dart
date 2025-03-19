import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repositories/child_repository.dart';
import '../data/models/child_model.dart';
part 'child_event.dart';
part 'child_state.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState> {
  final ChildRepository repository;

  ChildBloc({required this.repository}) : super(ChildInitial()) {
    on<FetchChildren>(_onFetchChildren);
    on<AddChild>(_onAddChild);
    on<UpdateChild>(_onUpdateChild);
    on<DeleteChild>(_onDeleteChild);
  }

  void _onFetchChildren(FetchChildren event, Emitter<ChildState> emit) async {
    try {
      emit(ChildLoading());
      final children = await repository.fetchChildren();
      emit(ChildrenLoaded(children));
    } catch (e) {
      emit(ChildError('Failed to fetch children'));
    }
  }

  void _onAddChild(AddChild event, Emitter<ChildState> emit) async {
    try {
      final child = await repository.addChild(event.child);
      emit(ChildAdded(child));
      emit(ChildLoading());

      // Após adicionar, buscar lista atualizada
      final children = await repository.fetchChildren();
      emit(ChildrenLoaded(children));
    } catch (e) {
      emit(ChildError('Failed to add child'));
    }
  }

  void _onUpdateChild(UpdateChild event, Emitter<ChildState> emit) async {
    try {
      final child = await repository.updateChild(event.child);
      emit(ChildUpdated(child));
      emit(ChildLoading());
      // Após atualizar, buscar lista atualizada
      final children = await repository.fetchChildren();
      emit(ChildrenLoaded(children));
    } catch (e) {
      emit(ChildError('Failed to update child'));
    }
  }

  void _onDeleteChild(DeleteChild event, Emitter<ChildState> emit) async {
    try {
      await repository.deleteChild(event.childId);
      emit(ChildDeleted());
      emit(ChildLoading());
      // Após deletar, buscar lista atualizada
      final children = await repository.fetchChildren();
      emit(ChildrenLoaded(children));
    } catch (e) {
      emit(ChildError('Failed to delete child'));
    }
  }
}
