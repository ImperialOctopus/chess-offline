import 'package:flutter/material.dart' hide Color;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter/material.dart' as material show Color;

import '../constants/constants.dart';
import 'chessboard_controller.dart';

import 'package:chess/chess.dart' hide State;

class Chessboard extends StatefulWidget {
  /// An instance of [ChessBoardController] which holds the game and allows
  /// manipulating the board programmatically.
  final ChessboardController controller;

  /// Size of chessboard
  final double? size;

  /// A boolean which checks if the user should be allowed to make moves
  final bool enableUserMoves;

  /// The color type of the board
  final BoardTheme boardTheme;

  final Color boardOrientation;

  const Chessboard({
    Key? key,
    required this.controller,
    this.size,
    this.enableUserMoves = true,
    this.boardTheme = BoardTheme.brown,
    this.boardOrientation = Color.WHITE,
  }) : super(key: key);

  @override
  State<Chessboard> createState() => _ChessboardState();
}

class _ChessboardState extends State<Chessboard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Chess>(
      valueListenable: widget.controller,
      builder: (context, game, _) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: _buildBoardBackground(widget.boardTheme),
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) {
                    var row = index ~/ 8;
                    var column = index % 8;
                    String boardRank = (widget.boardOrientation == Color.BLACK
                            ? row + 1
                            : (7 - row) + 1)
                        .toString();
                    String boardFile = widget.boardOrientation == Color.WHITE
                        ? files[column]
                        : files[7 - column];

                    String squareName = boardFile + boardRank;
                    Piece? pieceOnSquare = game.get(squareName);

                    return DragTarget<PieceMoveData>(
                      builder: (context, list, _) => pieceOnSquare != null
                          ? Draggable<PieceMoveData>(
                              feedback: PieceWidget(piece: pieceOnSquare),
                              childWhenDragging: const SizedBox(),
                              data: PieceMoveData(
                                squareName: squareName,
                                pieceType: pieceOnSquare.type,
                                pieceColor: pieceOnSquare.color,
                              ),
                              child: PieceWidget(piece: pieceOnSquare),
                            )
                          : Container(),
                      onWillAccept: (pieceMoveData) =>
                          widget.enableUserMoves ? true : false,
                      onAccept: (PieceMoveData pieceMoveData) async {
                        if (pieceMoveData.pieceType == PieceType.PAWN &&
                            ((pieceMoveData.squareName[1] == "7" &&
                                    squareName[1] == "8" &&
                                    pieceMoveData.pieceColor == Color.WHITE) ||
                                (pieceMoveData.squareName[1] == "2" &&
                                    squareName[1] == "1" &&
                                    pieceMoveData.pieceColor == Color.BLACK))) {
                          final promoteTo = await _promotionDialog(
                              context, pieceMoveData.pieceColor);

                          if (promoteTo == null) {
                            return;
                          } else {
                            widget.controller.makeMoveWithPromotion(
                              from: pieceMoveData.squareName,
                              to: squareName,
                              pieceToPromoteTo: promoteTo,
                            );
                          }
                        } else {
                          widget.controller.makeMove(
                            from: pieceMoveData.squareName,
                            to: squareName,
                          );
                        }
                      },
                    );
                  },
                  itemCount: 64,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBoardBackground(BoardTheme theme) {
    throw UnimplementedError();
  }

  /// Show dialog when pawn reaches last square
  Future<String?> _promotionDialog(BuildContext context, Color color) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose promotion'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                child: PieceWidget(piece: Piece(PieceType.QUEEN, color)),
                onTap: () {
                  Navigator.of(context).pop("q");
                },
              ),
              InkWell(
                child: PieceWidget(piece: Piece(PieceType.ROOK, color)),
                onTap: () {
                  Navigator.of(context).pop("r");
                },
              ),
              InkWell(
                child: PieceWidget(piece: Piece(PieceType.BISHOP, color)),
                onTap: () {
                  Navigator.of(context).pop("b");
                },
              ),
              InkWell(
                child: PieceWidget(piece: Piece(PieceType.KNIGHT, color)),
                onTap: () {
                  Navigator.of(context).pop("n");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class PieceWidget extends StatelessWidget {
  final Piece piece;

  const PieceWidget({
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
