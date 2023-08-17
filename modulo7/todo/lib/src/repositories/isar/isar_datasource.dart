import 'dart:async';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'task_model.dart';

class IsarDatasource {
  final completer = Completer<Isar>();

  IsarDatasource() {
    initIsar();
  }

  initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [TaskModelSchema],
      directory: dir.path,
    );
    completer.complete(isar);
  }

  Future<List<TaskModel?>> getTasks() async {
    final isar = await completer.future;
    return isar.taskModels.getAll([]);
  }

  Future<void> add(TaskModel model) async {
    final isar = await completer.future;
    await isar.taskModels.put(model);
  }

  Future<void> addAll(List<TaskModel> models) async {
    final isar = await completer.future;
    await isar.taskModels.putAll(models);
  }

  Future<void> remove(TaskModel model) async {
    final isar = await completer.future;
    await isar.taskModels.delete(model.id);
  }

  Future<void> removeAll() async {
    final isar = await completer.future;
    await isar.taskModels.deleteAll([]);
  }
}
