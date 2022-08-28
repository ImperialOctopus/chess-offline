import 'package:chess/chess.dart' hide State;
import 'package:flutter/material.dart' hide Color;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChessPiece extends StatelessWidget {
  final Piece piece;

  const ChessPiece({
    Key? key,
    required this.piece,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (piece.color == Color.WHITE) {
      if (piece.type == PieceType.PAWN) {
        return const FaIcon(FontAwesomeIcons.chessPawn);
      }
      if (piece.type == PieceType.ROOK) {
        return const FaIcon(FontAwesomeIcons.chessRook);
      }
      if (piece.type == PieceType.KNIGHT) {
        return const FaIcon(FontAwesomeIcons.chessKnight);
      }
      if (piece.type == PieceType.BISHOP) {
        return const FaIcon(FontAwesomeIcons.chessBishop);
      }
      if (piece.type == PieceType.QUEEN) {
        return const FaIcon(FontAwesomeIcons.chessQueen);
      }
      if (piece.type == PieceType.KING) {
        return const FaIcon(FontAwesomeIcons.chessKing);
      }
    } else {
      if (piece.type == PieceType.PAWN) {
        return const FaIcon(FontAwesomeIcons.solidChessPawn);
      }
      if (piece.type == PieceType.ROOK) {
        return const FaIcon(FontAwesomeIcons.solidChessRook);
      }
      if (piece.type == PieceType.KNIGHT) {
        return const FaIcon(FontAwesomeIcons.solidChessKnight);
      }
      if (piece.type == PieceType.BISHOP) {
        return const FaIcon(FontAwesomeIcons.solidChessBishop);
      }
      if (piece.type == PieceType.QUEEN) {
        return const FaIcon(FontAwesomeIcons.solidChessQueen);
      }
      if (piece.type == PieceType.KING) {
        return const FaIcon(FontAwesomeIcons.solidChessKing);
      }
    }
    throw FallThroughError();
  }
}
