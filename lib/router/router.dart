import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess/pages/game/game_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: GamePage, initial: true),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter();
}
