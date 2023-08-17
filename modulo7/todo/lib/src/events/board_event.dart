import '../models/task.dart';

sealed class BoardEvent {}

class FetchBoardEvent implements BoardEvent {}

class AddTaskBoardEvent implements BoardEvent {
  final Task task;
  AddTaskBoardEvent(this.task);
}

class RemoveTaskBoardEvent implements BoardEvent {
  final Task task;
  RemoveTaskBoardEvent(this.task);
}

class CheckTaskBoardEvent implements BoardEvent {
  final Task task;
  CheckTaskBoardEvent(this.task);
}
