import 'package:flutter/foundation.dart';
import 'package:flutter_chess/model/board_location.dart';
import 'package:flutter_chess/model/piece.dart';

import 'board_state.dart';

class BoardStateController
    with ChangeNotifier
    implements ValueListenable<BoardState> {
  final List<BoardState> history;

  BoardStateController(BoardState startingState) : history = [startingState];

  @override
  BoardState get value => history.last;

  bool get canUndo => history.length > 1;

  void undo() {
    if (canUndo) {
      history.removeLast();
      notifyListeners();
    }
  }

  void createPiece({
    required Piece piece,
    required BoardLocation location,
  }) {
    _update((state) => state.setPiece(location, piece));
  }

  void deletePiece({required BoardLocation location}) {
    _update((state) => state.setPiece(location, null));
  }

  void makeMoveWithPromotion({
    required BoardLocation origin,
    required BoardLocation destination,
    required PieceType promoteTo,
  }) {
    final originPiece = value.getPiece(origin)!;
    final destinationPiece = value.getPiece(destination);

    if (destinationPiece != null &&
        destinationPiece.color == originPiece.color) {
      // switch
      _update((state) => state
          .setPiece(origin, destinationPiece)
          .setPiece(destination, Piece(originPiece.color, promoteTo)));
    } else {
      // replace
      _update((state) => state
          .setPiece(origin, null)
          .setPiece(destination, Piece(originPiece.color, promoteTo)));
    }
  }

  void makeMove({
    required BoardLocation origin,
    required BoardLocation destination,
  }) {
    final originPiece = value.getPiece(origin)!;
    final destinationPiece = value.getPiece(destination);

    if (destinationPiece != null &&
        destinationPiece.color == originPiece.color) {
      // switch
      _update((state) => state
          .setPiece(origin, destinationPiece)
          .setPiece(destination, originPiece));
    } else {
      // replace
      _update((state) =>
          state.setPiece(origin, null).setPiece(destination, originPiece));
    }
  }

  void _update(BoardState Function(BoardState state) updateFunction) {
    final newState = updateFunction(value);
    history.add(newState);
    notifyListeners();
  }
}
