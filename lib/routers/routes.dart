import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/pages/create/create.dart';
import 'package:flutter_rpg/pages/home/home.dart';
import 'package:flutter_rpg/pages/home/test_page.dart';
import 'package:flutter_rpg/pages/me/me_page.dart';
import 'package:flutter_rpg/pages/profile/profile_page.dart';
import 'package:flutter_rpg/pages/todo/todo_page.dart';
import 'package:flutter_rpg/routers/my_shell_route_scree.dart';
import 'package:go_router/go_router.dart';
part 'routes.g.dart';

@TypedGoRoute<TestRoute>(path: '/')
class TestRoute extends GoRouteData {
  const TestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TestPage();
  }
}


class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Home();
  }
}


class MeRoute extends GoRouteData {
  const MeRoute();

    @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: const MePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
      );

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MePage();
  }
}


class CreateRoute extends GoRouteData {
  const CreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreatePage();
  }
}


class ProfileRoute extends GoRouteData {
  const ProfileRoute({required this.$extra});
  final Character $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // 展示一个ios present的效果
        return  ProfilePage(
      character: $extra,
    );
  }
}


class TodoRoute extends GoRouteData {
  const TodoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TodoPage();
  }
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@TypedShellRoute<MyShellRouteData>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(
      path: '/home', 
      routes:  [
    TypedGoRoute<MeRoute>(path: 'me'),
    TypedGoRoute<CreateRoute>(path: 'create'),
    TypedGoRoute<ProfileRoute>(path: 'profile')
  ]),
    TypedGoRoute<TodoRoute>(path: '/todo'),
  ],
)

class MyShellRouteData extends ShellRouteData {
  const MyShellRouteData();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MyShellRouteScreen(child: navigator);
  }
}

// CreatePage


// @TypedGoRoute<SplashRoute>(path: '/splash')
// class SplashRoute extends GoRouteData {
//   const SplashRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     return const SplashPage();
//   }
// }