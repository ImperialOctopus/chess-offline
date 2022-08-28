import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess/pages/game_page.dart';

import '../pages/menu_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(path: '/menu', page: MenuPage, initial: true),
    AutoRoute<void>(path: '/game', page: GamePage),
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter();
}
