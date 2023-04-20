// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:leavemanagementadmin/Authflow/auth_flow.dart' as _i1;
import 'package:leavemanagementadmin/pages/homepage.dart' as _i4;
import 'package:leavemanagementadmin/pages/loginpage.dart' as _i2;
import 'package:leavemanagementadmin/pages/sidebar.dart' as _i3;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    SidebarRoute.name: (routeData) {
      final args = routeData.argsAs<SidebarRouteArgs>(
          orElse: () => const SidebarRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.SidebarPage(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i5.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SidebarPage]
class SidebarRoute extends _i5.PageRouteInfo<SidebarRouteArgs> {
  SidebarRoute({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          SidebarRoute.name,
          args: SidebarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SidebarRoute';

  static const _i5.PageInfo<SidebarRouteArgs> page =
      _i5.PageInfo<SidebarRouteArgs>(name);
}

class SidebarRouteArgs {
  const SidebarRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'SidebarRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
