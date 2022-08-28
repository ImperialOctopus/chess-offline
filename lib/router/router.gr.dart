// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MenuRoute.name: (routeData) {
      return MaterialPageX<void>(routeData: routeData, child: const MenuPage());
    },
    GameRoute.name: (routeData) {
      return MaterialPageX<void>(routeData: routeData, child: const GamePage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/menu', fullMatch: true),
        RouteConfig(MenuRoute.name, path: '/menu'),
        RouteConfig(GameRoute.name, path: '/game')
      ];
}

/// generated route for
/// [MenuPage]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute() : super(MenuRoute.name, path: '/menu');

  static const String name = 'MenuRoute';
}

/// generated route for
/// [GamePage]
class GameRoute extends PageRouteInfo<void> {
  const GameRoute() : super(GameRoute.name, path: '/game');

  static const String name = 'GameRoute';
}
