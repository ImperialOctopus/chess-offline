const files = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

/// Enum which stores board types
enum BoardTheme {
  brown,
  darkBrown,
  orange,
  green,
}

RegExp squareRegex = RegExp("^[A-H|a-h][1-8]\$");
