import 'package:flutter/material.dart';
import 'package:chess_offline/services/audio_service.dart';
import 'package:chess_offline/services/audioplayers_audio_service.dart';
import 'package:chess_offline/theme/theme.dart';
import 'package:provider/provider.dart';

import 'router/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter router;

  @override
  void initState() {
    router = AppRouter();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AudioService>(
      create: (_) => AudioplayersAudioService(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: themeData,
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
      ),
    );
  }
}
