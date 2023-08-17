import 'package:todo/src/models/board.dart';

sealed class BoardState {}

class LoadingBoardState implements BoardState {}

class GettedBoardState implements BoardState {
  final Board board;

  GettedBoardState(this.board);
}

class EmptyBoardState extends GettedBoardState {
  EmptyBoardState() : super(Board(id: 0, title: '', tasks: []));
}

class FailureBoardState implements BoardState {
  final String message;

  FailureBoardState(this.message);
}
