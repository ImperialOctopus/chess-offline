import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/piece.dart';

class PieceWidget extends StatelessWidget {
  final Piece piece;

  const PieceWidget({super.key, required this.piece});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: icon,
      ),
    );
  }

  Widget get icon {
    switch (piece.color) {
      case PieceColor.white:
        {
          switch (piece.type) {
            case PieceType.pawn:
              {
                return const FaIcon(FontAwesomeIcons.chessPawn);
              }
            case PieceType.rook:
              {
                return const FaIcon(FontAwesomeIcons.chessRook);
              }
            case PieceType.knight:
              {
                return const FaIcon(FontAwesomeIcons.chessKnight);
              }
            case PieceType.bishop:
              {
                return const FaIcon(FontAwesomeIcons.chessBishop);
              }
            case PieceType.queen:
              {
                return const FaIcon(FontAwesomeIcons.chessQueen);
              }
            case PieceType.king:
              {
                return const FaIcon(FontAwesomeIcons.chessKing);
              }
          }
        }

      case PieceColor.black:
        {
          switch (piece.type) {
            case PieceType.pawn:
              {
                return const FaIcon(FontAwesomeIcons.solidChessPawn);
              }
            case PieceType.rook:
              {
                return const FaIcon(FontAwesomeIcons.solidChessRook);
              }
            case PieceType.knight:
              {
                return const FaIcon(FontAwesomeIcons.solidChessKnight);
              }
            case PieceType.bishop:
              {
                return const FaIcon(FontAwesomeIcons.solidChessBishop);
              }
            case PieceType.queen:
              {
                return const FaIcon(FontAwesomeIcons.solidChessQueen);
              }
            case PieceType.king:
              {
                return const FaIcon(FontAwesomeIcons.solidChessKing);
              }
          }
        }
    }
  }
}
