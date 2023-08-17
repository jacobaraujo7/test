import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/blocs/board_bloc.dart';
import 'package:todo/src/events/board_event.dart';
import 'package:todo/src/models/board.dart';
import 'package:todo/src/models/task.dart';
import 'package:todo/src/pages/home_page.dart';
import 'package:todo/src/states/board_states.dart';

class BoardBlocMock extends MockBloc<BoardEvent, BoardState> implements BoardBloc {}

void main() {
  final bloc = BoardBlocMock();
  tearDown(() => reset(bloc));

  testWidgets('home page with ok', (tester) async {
    final board = Board(id: 1, title: '', tasks: [
      Task(id: 1, description: 'description', check: false),
    ]);
    whenListen<BoardState>(
      bloc,
      Stream.fromIterable([LoadingBoardState(), GettedBoardState(board)]),
      initialState: EmptyBoardState(),
    );
    await tester.pumpWidget(
      BlocProvider<BoardBloc>(
        create: (context) => bloc,
        child: const MaterialApp(home: HomePage()),
      ),
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    expect(find.byKey(const Key('GettedState')), findsOneWidget);
  });

  testWidgets('home page with failure', (tester) async {
    whenListen<BoardState>(
      bloc,
      Stream.fromIterable([LoadingBoardState(), FailureBoardState('Error')]),
      initialState: EmptyBoardState(),
    );
    await tester.pumpWidget(
      BlocProvider<BoardBloc>(
        create: (context) => bloc,
        child: const MaterialApp(home: HomePage()),
      ),
    );

    expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    expect(find.byKey(const Key('FailureState')), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });
}
