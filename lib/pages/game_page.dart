import 'package:flutter/material.dart';
import 'package:flutter_chess/components/chessboard/chessboard_new.dart';

import '../components/chessboard/chessboard_controller.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final controller = ChessboardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OrientationBuilder(
        builder: (context, orientation) => orientation == Orientation.landscape
            ? Row(
                children: [
                  _buildChessboard(),
                  Expanded(
                    child: _buildSidebar(),
                  ),
                ],
              )
            : Column(
                children: [
                  _buildChessboard(),
                  Expanded(
                    child: _buildSidebar(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildChessboard() {
    return Chessboard(controller: controller);
  }

  Widget _buildSidebar() {
    return const Center(child: Text('Sidebar'));
  }
}
