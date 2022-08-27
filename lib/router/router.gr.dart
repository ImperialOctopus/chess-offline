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
    GameRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: GamePage());
    }
  };

  @override
  List<RouteConfig> get routes => [RouteConfig(GameRoute.name, path: '/')];
}

/// generated route for
/// [GamePage]
class GameRoute extends PageRouteInfo<void> {
  const GameRoute() : super(GameRoute.name, path: '/');

  static const String name = 'GameRoute';
}
