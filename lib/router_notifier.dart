import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_and_menu/dashboard_page.dart';
import 'package:routing_and_menu/menu_page.dart';
import 'package:routing_and_menu/participants_page.dart';
import 'package:routing_and_menu/shops_page.dart';

class RouterNotifier {
  static final RouterNotifier _instance = RouterNotifier._();

  factory RouterNotifier() {
    return _instance;
  }

  late final ValueNotifier<RoutingConfig> routerConfig;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final List<RouteBase> dashboardRoutes = [
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: DashboardPage()),
    ),
  ];

  static final List<RouteBase> participantsRoutes = [
    GoRoute(
      path: '/participants',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: ParticipantsPage()),
    ),
  ];

  static final List<RouteBase> shopsRoutes = [
    GoRoute(
      path: '/shops',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: ShopsPage()),
    ),
  ];

  late final GoRouter router;
  late final List<StatefulShellBranch> branches;

  StatefulNavigationShell? _navigationShell;

  RouterNotifier._() {
    branches = [
      StatefulShellBranch(
        navigatorKey: _shellNavigatorKey,
        routes: dashboardRoutes,
      ),
      StatefulShellBranch(
        routes: participantsRoutes,
      ),
      StatefulShellBranch(
        routes: shopsRoutes,
      ),
    ];

    routerConfig = ValueNotifier<RoutingConfig>(
      RoutingConfig(
        routes: [
          StatefulShellRoute.indexedStack(
            pageBuilder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell navigationShell) {
              _navigationShell = navigationShell;
              return NoTransitionPage(
                child: MenuPage(
                  navigationShell: navigationShell,
                ),
              );
            },
            branches: branches,
          ),
        ],
      ),
    );

    router = GoRouter.routingConfig(
      routingConfig: routerConfig,
      initialLocation: '/dashboard',
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
    );
  }

  void addBranch(StatefulShellBranch branch) {
    branches.add(branch);
    routerConfig.value = RoutingConfig(
      routes: [
        StatefulShellRoute.indexedStack(
          pageBuilder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            return NoTransitionPage(
              child: MenuPage(
                navigationShell: navigationShell,
              ),
            );
          },
          branches: branches,
        ),
      ],
    );
  }

  void goLatestBranch() {
    _navigationShell?.goBranch(branches.length - 1);
  }
}
