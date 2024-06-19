import 'package:flutter/material.dart';
import 'package:flutter_rpg/routers/routes.dart';
import 'package:go_router/go_router.dart';


class MyShellRouteScreen extends StatelessWidget {
  const MyShellRouteScreen({required this.child, super.key});

  final Widget child;

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/todo')) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = getCurrentIndex(context);

    return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Todos',
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (int index) {
              switch (index) {
                case 0:
                  const HomeRoute().go(context);
                  break;
                case 1:
                  const TodoRoute().go(context);
                  break;
              }
            }));
  }
}

// vertical alignment
    // return Scaffold(
    //   body: Row(
    //     children: <Widget>[
    //       NavigationRail(
    //         destinations: const <NavigationRailDestination>[
    //           NavigationRailDestination(
    //             icon: Icon(Icons.home),
    //             label: Text('Home'),
    //           ),
    //           NavigationRailDestination(
    //             icon: Icon(Icons.group),
    //             label: Text('Todos'),
    //           ),
    //         ],
    //         selectedIndex: selectedIndex,
    //         onDestinationSelected: (int index) {
    //           switch (index) {
    //             case 0:
    //               const HomeRoute().go(context);
    //             case 1:
    //               const TodoRoute().go(context);
    //           }
    //         },
    //       ),
    //       const VerticalDivider(thickness: 1, width: 1),
    //       Expanded(child: child),
    //     ],
    //   ),
    // );