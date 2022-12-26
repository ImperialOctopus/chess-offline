import 'package:flutter/material.dart';
import 'package:flutter_chess/services/audio_service.dart';
import 'package:provider/provider.dart';

import 'board_background.dart';
import 'piece_widget.dart';
import '../../model/board_state_controller.dart';
import '../../model/board_location.dart';
import '../../model/board_state.dart';
import '../../model/piece.dart';
import '../../theme/board_theme.dart';

class Chessboard extends StatefulWidget {
  /// The color type of the board
  final BoardTheme boardTheme;

  final bool flipBoard;

  final BoardStateController controller;

  static const List<String> fileLabels = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h'
  ];

  const Chessboard({
    super.key,
    required this.controller,
    this.boardTheme = BoardTheme.simpleAndClean,
    this.flipBoard = false,
  });

  @override
  State<Chessboard> createState() => _ChessboardState();
}

class _ChessboardState extends State<Chessboard> {
  @override
  Widget build(BuildContext context) {
    final audioService = Provider.of<AudioService>(context, listen: false);

    return ValueListenableBuilder<BoardState>(
      valueListenable: widget.controller,
      builder: (context, boardState, _) {
        return AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              BoardBackground(theme: widget.boardTheme),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8),
                itemBuilder: (context, index) {
                  int x = index % 8;
                  int y = index ~/ 8;

                  if (widget.flipBoard) {
                    x = 7 - x;
                    y = 7 - y;
                  }

                  final location = BoardLocation(x, y);

                  Piece? pieceOnSquare = boardState.getPiece(location);

                  return DragTarget<BoardLocation>(
                    builder: (context, list, _) => pieceOnSquare != null
                        ? LayoutBuilder(
                            builder: (context, constraints) =>
                                Draggable<BoardLocation>(
                              feedback: SizedBox(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                child: PieceWidget(piece: pieceOnSquare),
                              ),
                              childWhenDragging: SizedBox(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                              ),
                              data: location,
                              onDraggableCanceled: (_, __) {
                                widget.controller
                                    .deletePiece(location: location);
                                audioService
                                    .playSound(AudioServiceSound.capture);
                              },
                              child: SizedBox(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                child: PieceWidget(piece: pieceOnSquare),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onLongPress: () async {
                              final piece = await _createDialog(context);

                              if (piece == null) {
                                return;
                              } else {
                                widget.controller.createPiece(
                                  piece: piece,
                                  location: location,
                                );
                                audioService.playSound(AudioServiceSound.move);
                              }
                            },
                          ),
                    onAccept: (BoardLocation origin) async {
                      if (origin == location) {
                        return;
                      }

                      final pieceMoving = boardState.getPiece(origin);

                      if ((pieceMoving?.type == PieceType.pawn) &&
                          ((pieceMoving?.color == PieceColor.white &&
                                  location.y == 0) ||
                              (pieceMoving?.color == PieceColor.black &&
                                  location.y == 7))) {
                        final promoteTo =
                            await _promotionDialog(context, pieceMoving!.color);

                        if (promoteTo == null) {
                          return;
                        } else {
                          final result =
                              widget.controller.makeMoveWithPromotion(
                            origin: origin,
                            destination: location,
                            promoteTo: promoteTo.type,
                          );
                          result.pieceCaptured
                              ? audioService
                                  .playSound(AudioServiceSound.capture)
                              : audioService.playSound(AudioServiceSound.move);
                          return;
                        }
                      } else {
                        final result = widget.controller.makeMove(
                          origin: origin,
                          destination: location,
                        );
                        result.pieceCaptured
                            ? audioService.playSound(AudioServiceSound.capture)
                            : audioService.playSound(AudioServiceSound.move);
                        return;
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
  Future<Piece?> _promotionDialog(
      BuildContext context, PieceColor color) async {
    return showDialog<Piece>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('promotion'),
          content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PieceType.queen,
                PieceType.bishop,
                PieceType.knight,
                PieceType.rook,
              ].map((pieceType) {
                return SizedBox(
                  height: 64,
                  width: 64,
                  child: InkWell(
                    child: PieceWidget(
                      piece: Piece(color, pieceType),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(Piece(color, pieceType));
                    },
                  ),
                );
              }).toList()),
        );
      },
    );
  }

  /// Show dialog when create piece button is pressed
  Future<Piece?> _createDialog(BuildContext context) async {
    return showDialog<Piece>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('create'),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PieceColor.white,
                PieceColor.black,
              ].map((pieceColor) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PieceType.king,
                      PieceType.queen,
                      PieceType.bishop,
                      PieceType.knight,
                      PieceType.rook,
                      PieceType.pawn,
                    ].map((pieceType) {
                      return SizedBox(
                        height: 64,
                        width: 64,
                        child: InkWell(
                          child: PieceWidget(
                            piece: Piece(pieceColor, pieceType),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pop(Piece(pieceColor, pieceType));
                          },
                        ),
                      );
                    }).toList());
              }).toList()),
        );
      },
    );
  }
}
