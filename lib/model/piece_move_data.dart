import 'package:chess/chess.dart';

class PieceMoveData {
  final String squareName;
  final PieceType pieceType;
  final Color pieceColor;

  PieceMoveData({
    required this.squareName,
    required this.pieceType,
    required this.pieceColor,
  });
}
