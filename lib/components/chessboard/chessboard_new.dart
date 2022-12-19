import 'package:chess/chess.dart' hide State;
import 'package:flutter/material.dart' hide Color;
import 'package:flutter_chess/components/chessboard/board_background.dart';

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

  static const List<String> files = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  Chessboard({
    super.key,
    ChessboardController? controller,
    this.enableUserMoves = true,
    this.boardTheme = BoardTheme.simpleAndClean,
    this.boardOrientation = Color.WHITE,
  }) : controller = controller ?? ChessboardController();

  @override
  State<Chessboard> createState() => _ChessboardState();
}

class _ChessboardState extends State<Chessboard> {
  bool? availableMovesCanBeShowed = false;
  PieceMoveData? selectedPieceMoveData;

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
                  final row = index ~/ 8;
                  final column = index % 8;
                  final boardRank = (widget.boardOrientation == Color.BLACK
                          ? row + 1
                          : (7 - row) + 1)
                      .toString();
                  final boardFile = widget.boardOrientation == Color.WHITE
                      ? Chessboard.files[column]
                      : Chessboard.files[7 - column];

                  final squareName = boardFile + boardRank;
                  final piece = game.get(squareName);

                  return DragTarget<PieceMoveData>(
                    builder: (context, list, _) => piece != null
                        ? _buildDraggable(piece, squareName)
                        : Container(),
                    onWillAccept: (pieceMoveData) =>
                        widget.enableUserMoves ? true : false,
                    onAccept: _onDragAccept,
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

  Widget _buildDraggable(Piece piece, String square) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pieceWidget = SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: ChessPiece(piece: piece),
        );
        return Draggable<PieceMoveData>(
          feedback: pieceWidget,
          childWhenDragging: const SizedBox(),
          data: PieceMoveData(
            squareName: square,
            pieceType: piece.type,
            pieceColor: piece.color,
          ),
          child: pieceWidget,
        );
      },
    );
  }

  void _onDragAccept(PieceMoveData pieceMoveData) async {
    if (pieceMoveData.pieceType == PieceType.PAWN &&
        ((pieceMoveData.squareName[1] == "7" &&
                pieceMoveData.squareName[1] == "8" &&
                pieceMoveData.pieceColor == Color.WHITE) ||
            (pieceMoveData.squareName[1] == "2" &&
                pieceMoveData.squareName[1] == "1" &&
                pieceMoveData.pieceColor == Color.BLACK))) {
      final promoteTo =
          await _promotionDialog(context, pieceMoveData.pieceColor);

      if (promoteTo == null) {
        return;
      } else {
        widget.controller.makeMoveWithPromotion(
          from: pieceMoveData.squareName,
          to: pieceMoveData.squareName,
          pieceToPromoteTo: promoteTo,
        );
      }
    } else {
      widget.controller.makeMove(
        from: pieceMoveData.squareName,
        to: pieceMoveData.squareName,
      );
    }
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
