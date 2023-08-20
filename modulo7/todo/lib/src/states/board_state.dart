import 'package:todo/src/models/task.dart';

sealed class BoardState {}

class LoadingBoardState implements BoardState {}

class GettedTasksBoardState implements BoardState {
  final List<Task> tasks;

  GettedTasksBoardState({required this.tasks});
}

class EmptyBoardState extends GettedTasksBoardState {
  EmptyBoardState() : super(tasks: []);
}

class FailureBoardState implements BoardState {
  final String message;

  FailureBoardState(this.message);
}
