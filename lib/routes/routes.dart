import 'package:feast_mobile_email/features/event_details_page.dart/event_details_page.dart';
import 'package:feast_mobile_email/features/event_list_page/event_list_page.dart';
import 'package:feast_mobile_email/features/filters_page/filters_page.dart';
import 'package:feast_mobile_email/features/test_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter = GoRouter(initialLocation: '/profile', routes: [
  GoRoute(
      path: '/event_details',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: EventDetailsPage());
      }),
  GoRoute(
      path: '/event_filters',
      pageBuilder: (context, state) {
        return NoTransitionPage(child: FiltersPage());
      }),
  StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/event_list',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: EventListPage()))
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/routes',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: TestPage()))
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/profile',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: TestPage()))
        ])
      ])
]);

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        selectedIndex: navigationShell.currentIndex,
        indicatorColor: Colors.white,
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.flag),
              selectedIcon: Icon(Icons.flag, color: Colors.blue),
              label: 'Мероприятия'),
          NavigationDestination(
              icon: Icon(Icons.list_alt),
              selectedIcon: Icon(Icons.list_alt, color: Colors.blue),
              label: 'Расписание'),
          NavigationDestination(
              icon: Icon(Icons.person),
              selectedIcon: Icon(Icons.person, color: Colors.blue),
              label: 'Профиль')
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
