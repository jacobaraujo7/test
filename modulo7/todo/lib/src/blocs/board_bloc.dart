import 'package:bloc/bloc.dart';
import 'package:todo/src/events/board_event.dart';
import 'package:todo/src/states/board_states.dart';

import '../repositories/board_repository.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final BoardRepository repository;

  BoardBloc(this.repository) : super(EmptyBoardState()) {
    on<FetchBoardEvent>(_fetchBoardEvent);
    on<AddTaskBoardEvent>(_addTaskBoardEvent);
    on<RemoveTaskBoardEvent>(_removeTaskBoardEvent);
    on<CheckTaskBoardEvent>(_checkTaskBoardEvent);
  }

  void _fetchBoardEvent(event, emit) async {
    emit(LoadingBoardState());
    try {
      final board = await repository.fetch();
      emit(GettedBoardState(board));
    } catch (e) {
      emit(FailureBoardState('Erro ao pegar board'));
    }
  }

  void _addTaskBoardEvent(AddTaskBoardEvent event, emit) async {
    final state = this.state;
    if (state is! GettedBoardState) {
      return;
    }
    final newBoard = state.board.copyWith(tasks: [
      ...state.board.tasks,
      event.task,
    ]);

    try {
      await repository.update(newBoard);
      emit(GettedBoardState(newBoard));
    } catch (e) {
      emit(FailureBoardState('Error'));
    }
  }

  void _removeTaskBoardEvent(RemoveTaskBoardEvent event, emit) async {
    final state = this.state;
    if (state is! GettedBoardState) {
      return;
    }

    final tasks = state.board.tasks.toList();
    tasks.remove(event.task);

    final newBoard = state.board.copyWith(tasks: tasks);

    try {
      await repository.update(newBoard);
      emit(GettedBoardState(newBoard));
    } catch (e) {
      emit(FailureBoardState('Error'));
    }
  }

  void _checkTaskBoardEvent(CheckTaskBoardEvent event, emit) async {
    final state = this.state;
    if (state is! GettedBoardState) {
      return;
    }

    final tasks = state.board.tasks.toList();

    final index = tasks.indexOf(event.task);
    if (index == -1) {
      emit(FailureBoardState('Error'));
      return;
    }

    final checkedTask = event.task.copyWith(check: !event.task.check);
    tasks[index] = checkedTask;

    final newBoard = state.board.copyWith(tasks: tasks);

    try {
      await repository.update(newBoard);
      emit(GettedBoardState(newBoard));
    } catch (e) {
      emit(FailureBoardState('Error'));
    }
  }
}
