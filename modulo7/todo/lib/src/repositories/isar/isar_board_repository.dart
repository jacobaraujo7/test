import 'package:todo/src/models/board.dart';
import 'package:todo/src/models/task.dart';
import 'package:todo/src/repositories/isar/task_model.dart';

import '../board_repository.dart';
import 'isar_datasource.dart';

class IsarBoardRepository implements BoardRepository {
  final IsarDatasource datasource;

  IsarBoardRepository(this.datasource);

  @override
  Future<Board> fetch() async {
    final models = await datasource.getTasks();
    final tasks = models
        .map(
          (e) => Task(
            id: e!.id,
            description: e.description,
            check: e.check,
          ),
        )
        .toList();
    return Board(id: 1, title: 'default', tasks: tasks);
  }

  @override
  Future<Board> update(Board board) async {
    await datasource.removeAll();
    final models = board.tasks
        .map((e) => TaskModel() //
          ..id = e.id
          ..check = e.check
          ..description = e.description)
        .toList();

    await datasource.addAll(models);

    return board;
  }
}
