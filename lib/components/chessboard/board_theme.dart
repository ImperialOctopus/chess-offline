import 'package:flutter/material.dart';

class BoardTheme {
  final Color whiteColour;
  final Color blackColour;

  const BoardTheme._({required this.whiteColour, required this.blackColour});

  static const BoardTheme simpleAndClean = BoardTheme._(
    whiteColour: Colors.white,
    blackColour: Colors.black26,
  );
}
