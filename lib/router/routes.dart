import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animations/animations.dart';

import 'package:atec/screens/screens.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> defaultShellNavigatorkey = GlobalKey<NavigatorState>();

@TypedShellRoute<DefaultShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/home', routes: [
      TypedGoRoute<InspectRoute>(path: 'inspect'),
    ]),
    TypedGoRoute<PatientsRoute>(path: '/patients'),
  ],
)
class DefaultShellRoute extends ShellRouteData {
  const DefaultShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = defaultShellNavigatorkey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return DefaultShellScreen(navigator: navigator);
  }
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      );
}

class PatientsRoute extends GoRouteData {
  const PatientsRoute();

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PatientsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      );
}

class InspectRoute extends GoRouteData {
  const InspectRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage(
        key: state.pageKey,
        child: const InspectScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
      );
}
