import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/blocs/board_bloc.dart';
import 'package:todo/src/pages/home_page.dart';
import 'package:todo/src/repositories/isar/isar_board_repository.dart';
import 'package:todo/src/repositories/isar/isar_datasource.dart';

import 'src/repositories/board_repository.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<BoardRepository>(create: (_) => IsarBoardRepository(IsarDatasource())),
        BlocProvider(create: (ctx) => BoardBloc(ctx.read())),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
