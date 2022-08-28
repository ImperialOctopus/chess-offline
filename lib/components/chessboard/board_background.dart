import 'package:flutter/material.dart';
import 'package:flutter_chess/components/chessboard/board_theme.dart';

class BoardBackground extends StatelessWidget {
  final BoardTheme theme;

  const BoardBackground({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
      itemBuilder: (context, index) {
        if ((index + index ~/ 8).isEven) {
          // Black square
          return Container(color: theme.blackColour);
        } else {
          // White square
          return Container(color: theme.whiteColour);
        }
      },
    );
  }
}
