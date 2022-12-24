import 'package:equatable/equatable.dart';

import 'board_location.dart';
import 'piece.dart';

class BoardState extends Equatable {
  const BoardState._(List<List<Piece?>> startingState) : _board = startingState;

  static const BoardState starting = BoardState._(
    [
      [
        Piece(PieceColor.black, PieceType.rook),
        Piece(PieceColor.black, PieceType.knight),
        Piece(PieceColor.black, PieceType.bishop),
        Piece(PieceColor.black, PieceType.queen),
        Piece(PieceColor.black, PieceType.king),
        Piece(PieceColor.black, PieceType.bishop),
        Piece(PieceColor.black, PieceType.knight),
        Piece(PieceColor.black, PieceType.rook),
      ],
      [
        Piece(PieceColor.black, PieceType.pawn),
        Piece(PieceColor.black, PieceType.pawn),
        Piece(PieceColor.black, PieceType.pawn),
        Piece(PieceColor.black, PieceType.pawn),
        Piece(PieceColor.black, PieceType.pawn),
        Piece(PieceColor.black, PieceType.pawn),
        Piece(PieceColor.black, PieceType.pawn),
        Piece(PieceColor.black, PieceType.pawn),
      ],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [
        Piece(PieceColor.white, PieceType.pawn),
        Piece(PieceColor.white, PieceType.pawn),
        Piece(PieceColor.white, PieceType.pawn),
        Piece(PieceColor.white, PieceType.pawn),
        Piece(PieceColor.white, PieceType.pawn),
        Piece(PieceColor.white, PieceType.pawn),
        Piece(PieceColor.white, PieceType.pawn),
        Piece(PieceColor.white, PieceType.pawn),
      ],
      [
        Piece(PieceColor.white, PieceType.rook),
        Piece(PieceColor.white, PieceType.knight),
        Piece(PieceColor.white, PieceType.bishop),
        Piece(PieceColor.white, PieceType.queen),
        Piece(PieceColor.white, PieceType.king),
        Piece(PieceColor.white, PieceType.bishop),
        Piece(PieceColor.white, PieceType.knight),
        Piece(PieceColor.white, PieceType.rook),
      ],
    ],
  );

  static const BoardState empty = BoardState._(
    [
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
      [null, null, null, null, null, null, null, null],
    ],
  );

  final List<List<Piece?>> _board;

  Piece? getPiece(BoardLocation location) {
    return _board[location.y][location.x];
  }

  BoardState setPiece(BoardLocation location, Piece? piece) {
    final newMap = _board.map((list) => list.toList()).toList();
    newMap[location.y][location.x] = piece;
    return BoardState._(newMap);
  }

  @override
  List<Object?> get props => _board;
}
