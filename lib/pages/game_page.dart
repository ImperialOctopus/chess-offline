import 'package:flutter/material.dart';
import 'package:flutter_chess/components/chessboard/chessboard.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Chessboard(),
      ),
    );
  }
}
