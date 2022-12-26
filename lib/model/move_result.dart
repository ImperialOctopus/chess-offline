import 'package:equatable/equatable.dart';

class MoveResult extends Equatable {
  final bool pieceCaptured;

  const MoveResult({required this.pieceCaptured});

  @override
  List<Object?> get props => [pieceCaptured];
}
