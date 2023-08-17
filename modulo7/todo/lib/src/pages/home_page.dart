import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/events/board_event.dart';
import 'package:todo/src/states/board_states.dart';

import '../blocs/board_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BoardBloc>().add(FetchBoardEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<BoardBloc>();
    final state = bloc.state;

    Widget body = Container();
    if (state is EmptyBoardState) {
      body = const Center(
        key: Key('EmptyState'),
        child: Text('Adicione uma Task'),
      );
    } else if (state is GettedBoardState) {
      final tasks = state.board.tasks;
      body = ListView.builder(
        key: const Key('GettedState'),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return CheckboxListTile(
            value: task.check,
            title: Text(task.description),
            onChanged: (value) {
              bloc.add(CheckTaskBoardEvent(task));
            },
          );
        },
      );
    } else if (state is FailureBoardState) {
      body = Center(
        key: const Key('FailureState'),
        child: Text(state.message),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Board'),
      ),
      body: body,
    );
  }
}
