import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  // final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  // ref
  // ..onDispose(isAuth.dispose) // don't forget to clean after yourselves (:
  // update the listenable, when some provider value changes
  // here, we are just interested in wheter the user's logged in
  // ..listen(
  //   authControllerProvider.select((value) => value.whenData((value) => value.isAuth)),
  //   (_, next) {
  //     isAuth.value = next;
  //   },
  // );
  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: $appRoutes,
    // refreshListenable: isAuth,
    initialLocation: const TestRoute().location,
    debugLogDiagnostics: true,
    redirect: (context, state) {},
  );
  ref.onDispose(router.dispose);
  return router;
}
