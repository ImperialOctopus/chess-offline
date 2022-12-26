import 'package:flutter/material.dart';
import 'package:chess_offline/model/board_state.dart';
import 'package:chess_offline/model/board_state_controller.dart';
import 'package:chess_offline/services/audio_service.dart';
import 'package:provider/provider.dart';

import '../components/chessboard/chessboard.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool flipBoard = false;
  final BoardStateController controller =
      BoardStateController(BoardState.starting);

  @override
  Widget build(BuildContext context) {
    final audioService = Provider.of<AudioService>(context);

    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Chessboard(controller: controller, flipBoard: flipBoard)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                iconSize: 48,
                onPressed: () => Navigator.of(context).pop(),
              ),
              IconButton(
                icon: const Icon(Icons.screen_rotation_alt_rounded),
                iconSize: 48,
                onPressed: () {
                  audioService.playSound(AudioServiceSound.flip);
                  setState(() {
                    flipBoard = !flipBoard;
                  });
                },
              ),
              ValueListenableBuilder<BoardState>(
                valueListenable: controller,
                builder: (context, _, __) => IconButton(
                  icon: const Icon(Icons.undo),
                  iconSize: 48,
                  onPressed: controller.canUndo
                      ? () {
                          audioService.playSound(AudioServiceSound.undo);
                          controller.undo();
                        }
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
