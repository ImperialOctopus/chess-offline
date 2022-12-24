import 'package:equatable/equatable.dart';

enum PieceColor {
  white,
  black,
}

enum PieceType {
  pawn,
  rook,
  knight,
  bishop,
  queen,
  king,
}

class Piece extends Equatable {
  final PieceColor color;
  final PieceType type;

  const Piece(this.color, this.type);

  @override
  List<Object?> get props => [color, type];
}
