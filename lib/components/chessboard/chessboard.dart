import 'package:chess/chess.dart' hide State;
import 'package:flutter/material.dart' hide Color;
import 'package:flutter_chess/components/chessboard/board_background.dart';

import '../../constants/constants.dart';
import 'board_theme.dart';
import 'chess_piece.dart';
import 'chessboard_controller.dart';
import '../../model/piece_move_data.dart';

class Chessboard extends StatefulWidget {
  /// An instance of [ChessboardController] which holds the game and allows
  /// manipulating the board programmatically.
  final ChessboardController controller;

  /// A boolean which checks if the user should be allowed to make moves
  final bool enableUserMoves;

  /// The color type of the board
  final BoardTheme boardTheme;

  final Color boardOrientation;

  Chessboard({
    super.key,
    Chess? gameState,
    this.enableUserMoves = true,
    this.boardTheme = BoardTheme.simpleAndClean,
    this.boardOrientation = Color.WHITE,
  }) : controller = gameState == null
            ? ChessboardController()
            : ChessboardController.fromGame(gameState);

  @override
  State<Chessboard> createState() => _ChessboardState();
}

class _ChessboardState extends State<Chessboard> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Chess>(
      valueListenable: widget.controller,
      builder: (context, game, _) {
        return AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              BoardBackground(theme: widget.boardTheme),
              GridView.builder(
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
                            feedback: ChessPiece(piece: pieceOnSquare),
                            childWhenDragging: const SizedBox(),
                            data: PieceMoveData(
                              squareName: squareName,
                              pieceType: pieceOnSquare.type,
                              pieceColor: pieceOnSquare.color,
                            ),
                            child: ChessPiece(piece: pieceOnSquare),
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
            ],
          ),
        );
      },
    );
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
                child: ChessPiece(piece: Piece(PieceType.QUEEN, color)),
                onTap: () {
                  Navigator.of(context).pop("q");
                },
              ),
              InkWell(
                child: ChessPiece(piece: Piece(PieceType.ROOK, color)),
                onTap: () {
                  Navigator.of(context).pop("r");
                },
              ),
              InkWell(
                child: ChessPiece(piece: Piece(PieceType.BISHOP, color)),
                onTap: () {
                  Navigator.of(context).pop("b");
                },
              ),
              InkWell(
                child: ChessPiece(piece: Piece(PieceType.KNIGHT, color)),
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
