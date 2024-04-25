import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'routes.dart';

part 'router.g.dart';


@riverpod
GoRouter router (RouterRef ref) {
  return GoRouter(
    routes: $appRoutes,
    navigatorKey: rootNavigatorKey,
    initialLocation: const HomeRoute().location,
  );
}