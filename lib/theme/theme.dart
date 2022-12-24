import 'package:flutter/material.dart';

final themeData = ThemeData(
  // Define the default brightness and colors.
  //primaryColor: Colors.lightBlue[800],

  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.deepPurple,
    accentColor: Colors.amber,
    brightness: Brightness.light,
  ),

  // Define the default font family.
  //fontFamily: 'Georgia',

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  //textTheme: const TextTheme(
  //  headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  //  headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  //  bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  //),
  useMaterial3: true,
);
