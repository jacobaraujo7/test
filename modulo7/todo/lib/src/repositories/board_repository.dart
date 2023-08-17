import '../models/board.dart';

abstract class BoardRepository {
  Future<Board> fetch();
  Future<Board> update(Board board);
}
