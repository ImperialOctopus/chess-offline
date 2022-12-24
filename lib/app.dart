import 'package:flutter/material.dart';
import 'package:flutter_chess/theme/theme.dart';

import 'router/router.dart';

class App extends StatelessWidget {
  App({super.key});

  final router = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: themeData,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
    );
  }
}
