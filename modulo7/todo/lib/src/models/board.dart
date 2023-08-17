// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'task.dart';

class Board {
  final int id;
  final String title;
  final List<Task> tasks;

  Board({
    required this.id,
    required this.title,
    required this.tasks,
  });

  Board copyWith({
    int? id,
    String? title,
    List<Task>? tasks,
  }) {
    return Board(
      id: id ?? this.id,
      title: title ?? this.title,
      tasks: tasks ?? this.tasks,
    );
  }
}
