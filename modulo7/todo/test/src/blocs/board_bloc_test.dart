import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/blocs/board_bloc.dart';
import 'package:todo/src/events/board_event.dart';
import 'package:todo/src/models/board.dart';
import 'package:todo/src/models/task.dart';
import 'package:todo/src/repositories/board_repository.dart';
import 'package:todo/src/states/board_states.dart';

class BoardRepositoryMock extends Mock implements BoardRepository {}

class BoardMock extends Mock implements Board {}

void main() {
  final repository = BoardRepositoryMock();

  setUpAll(() {
    registerFallbackValue(BoardMock());
  });

  tearDown(() => reset(repository));

  group('Fetch |', () {
    blocTest<BoardBloc, BoardState>(
      'Deve pegar o board',
      build: () {
        when(() => repository.fetch()).thenAnswer((_) async => BoardMock());
        return BoardBloc(repository);
      },
      act: (bloc) => bloc.add(FetchBoardEvent()),
      expect: () => [
        isA<LoadingBoardState>(),
        isA<GettedBoardState>(),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'Deve pegar retornar estado de erro ao falhar',
      build: () {
        when(() => repository.fetch()).thenThrow(Exception('Error'));
        return BoardBloc(repository);
      },
      act: (bloc) => bloc.add(FetchBoardEvent()),
      expect: () => [
        isA<LoadingBoardState>(),
        isA<FailureBoardState>(),
      ],
    );
  });

  group('Add |', () {
    blocTest<BoardBloc, BoardState>(
      'Deve Adicionar uma nova task',
      build: () {
        when(() => repository.update(any())).thenAnswer((_) async => BoardMock());
        return BoardBloc(repository);
      },
      act: (bloc) {
        bloc.add(
          AddTaskBoardEvent(Task(id: 2, description: 'description', check: false)),
        );
      },
      expect: () => [
        isA<GettedBoardState>(),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'Deve retornar estado de erro ao falhar',
      build: () {
        when(() => repository.update(any())).thenThrow(Exception('Error'));
        return BoardBloc(repository);
      },
      act: (bloc) => bloc.add(
        AddTaskBoardEvent(Task(id: 2, description: 'description', check: false)),
      ),
      expect: () => [
        isA<FailureBoardState>(),
      ],
    );
  });
  group('Remove |', () {
    blocTest<BoardBloc, BoardState>(
      'Deve Remove uma task',
      build: () {
        when(() => repository.update(any())).thenAnswer((_) async => BoardMock());
        return BoardBloc(repository);
      },
      act: (bloc) {
        bloc.add(
          RemoveTaskBoardEvent(Task(id: 2, description: 'description', check: false)),
        );
      },
      expect: () => [
        isA<GettedBoardState>(),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'Deve retornar estado de erro ao falhar',
      build: () {
        when(() => repository.update(any())).thenThrow(Exception('Error'));
        return BoardBloc(repository);
      },
      act: (bloc) => bloc.add(
        RemoveTaskBoardEvent(Task(id: 2, description: 'description', check: false)),
      ),
      expect: () => [
        isA<FailureBoardState>(),
      ],
    );
  });

  group('Check |', () {
    blocTest<BoardBloc, BoardState>(
      'Deve checar uma task',
      build: () {
        when(() => repository.update(any())).thenAnswer((_) async => BoardMock());
        return BoardBloc(repository);
      },
      act: (bloc) async {
        final task = Task(id: 2, description: 'description', check: false);
        bloc.add(AddTaskBoardEvent(task));
        await Future.delayed(const Duration(milliseconds: 500));
        bloc.add(
          CheckTaskBoardEvent(task),
        );
      },
      expect: () => [
        isA<GettedBoardState>(),
        isA<GettedBoardState>(),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'Deve retornar estado de erro se a task nao existir no board',
      build: () {
        when(() => repository.update(any())).thenThrow(Exception('Error'));
        return BoardBloc(repository);
      },
      act: (bloc) {
        bloc.add(
          CheckTaskBoardEvent(Task(id: 1, description: '', check: false)),
        );
      },
      expect: () => [
        isA<FailureBoardState>(),
      ],
    );
    blocTest<BoardBloc, BoardState>(
      'Deve retornar estado de erro ao falhar',
      build: () {
        when(() => repository.update(any())).thenThrow(Exception('Error'));
        return BoardBloc(repository);
      },
      act: (bloc) => bloc.add(
        CheckTaskBoardEvent(Task(id: 2, description: 'description', check: false)),
      ),
      expect: () => [
        isA<FailureBoardState>(),
      ],
    );
  });
}
