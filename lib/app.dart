import 'package:flutter/material.dart';

import 'router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  final router = const AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
    );
  }
}
