import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/models/board.dart';
import 'package:todo/src/models/task.dart';
import 'package:todo/src/repositories/isar/isar_board_repository.dart';
import 'package:todo/src/repositories/isar/isar_datasource.dart';
import 'package:todo/src/repositories/isar/task_model.dart';

class IsarDatasourceMock extends Mock implements IsarDatasource {}

void main() {
  final datasource = IsarDatasourceMock();
  final repository = IsarBoardRepository(datasource);
  tearDown(() => reset(datasource));

  group('fetch |', () {
    test('Deve retornar um board', () async {
      final model = TaskModel() //
        ..id = 1
        ..check = false
        ..description = 'description';
      when(() => datasource.getTasks()).thenAnswer((_) async => [model]);

      final result = await repository.fetch();

      expect(result.tasks.length, 1);
      expect(result.tasks.first.id, 1);
      expect(result.tasks.first.check, false);
      expect(result.tasks.first.description, 'description');
    });
  });

  group('update |', () {
    test('Deve atualizar um board adicionando task', () async {
      when(() => datasource.removeAll()).thenAnswer((_) async => []);
      when(() => datasource.addAll(any())).thenAnswer((_) async => []);
      final board = Board(id: 1, title: '', tasks: [
        Task(id: 1, description: 'description', check: false),
      ]);

      final result = await repository.update(board);

      expect(result.tasks.length, 1);
      expect(result.tasks.first.id, 1);
      expect(result.tasks.first.check, false);
      expect(result.tasks.first.description, 'description');
    });
  });
}
