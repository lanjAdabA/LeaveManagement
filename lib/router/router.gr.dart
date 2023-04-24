// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:leavemanagementadmin/Authflow/auth_flow.dart' as _i1;
import 'package:leavemanagementadmin/pages/homepage.dart' as _i2;
import 'package:leavemanagementadmin/pages/leaveBalance.page.dart' as _i6;
import 'package:leavemanagementadmin/pages/loginpage.dart' as _i3;
import 'package:leavemanagementadmin/pages/newpage.dart' as _i4;
import 'package:leavemanagementadmin/pages/sidebar.dart' as _i5;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    NewRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.NewPage(),
      );
    },
    SidebarRoute.name: (routeData) {
      final args = routeData.argsAs<SidebarRouteArgs>(
          orElse: () => const SidebarRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.SidebarPage(key: args.key),
      );
    },
    LeaveBalanceRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LeaveBalancePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i7.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.NewPage]
class NewRoute extends _i7.PageRouteInfo<void> {
  const NewRoute({List<_i7.PageRouteInfo>? children})
      : super(
          NewRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SidebarPage]
class SidebarRoute extends _i7.PageRouteInfo<SidebarRouteArgs> {
  SidebarRoute({
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SidebarRoute.name,
          args: SidebarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SidebarRoute';

  static const _i7.PageInfo<SidebarRouteArgs> page =
      _i7.PageInfo<SidebarRouteArgs>(name);
}

class SidebarRouteArgs {
  const SidebarRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'SidebarRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.LeaveBalancePage]
class LeaveBalanceRoute extends _i7.PageRouteInfo<void> {
  const LeaveBalanceRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LeaveBalanceRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaveBalanceRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
