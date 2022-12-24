import 'package:equatable/equatable.dart';

class BoardLocation extends Equatable {
  final int x;
  final int y;

  const BoardLocation(this.x, this.y);

  @override
  List<Object?> get props => [x, y];
}
